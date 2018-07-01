# -*- python -*-

# Copyright 2018 Josh Pieper, jjp@pobox.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "patch")
load("@com_github_mjbots_bazel_deps//tools/workspace:makefile.bzl", "makefile_parse", "format_makefile")
load("@com_github_mjbots_bazel_deps//tools/workspace/ffmpeg:config.bzl",
     "flatten_config")

CONFIG_PREFIXES = {
    "" : None,
    "X86ASM-" : None,
    "MMX-" : None,
    "NEON-" : None,
    "ARMV6-" : None,
}

def _flatten(src):
    return [inner for outer in src for inner in outer]

def _format_dict(data):
    result = "{\n"

    for key, values in data.items():
        result += '"{}" : ['.format(key)
        for value in values:
            result += '"{}", '.format(value)
        result += '],\n'

    result += "}\n"
    return result

def _format_list(data):
    result = '[\n'
    for item in data:
        result += " '{}',\n".format(item)
    result += ']\n'
    return result

def _parse_optional(make_dict):
    result = {}
    for key, value in make_dict.items():
        location = key.find("OBJS-$(CONFIG_")
        if location == -1:
            continue

        prefix = key[0:location]
        if prefix not in CONFIG_PREFIXES:
            continue

        new_key = key[location:].replace("OBJS-$(CONFIG_", "")[:-1]

        result[new_key] = (
            result.get(new_key, []) +
            [x for x in value
             if x.find('$') == -1])
    return result

def _endswith_one_of(name, things):
    for thing in things:
        if name.endswith(thing):
            return True
    return False

def _make_list(ctx, config_dict, predicate, header, item, strip, output):
    all_list = '\n'.join([
        header] + [
            item.format(x.replace("#define CONFIG_", "").replace(strip, "").lower())
            for x in config_dict.keys() if _endswith_one_of(x, predicate)] + [
                    'NULL };'])

    ctx.file(
        output,
        content = all_list)

def _sourcify(ctx, name):
    # Figure out what extension this source file actually has.
    for extension in [".c", ".asm", ".S"]:
        maybe_name = name.replace(".o", extension)
        if ctx.execute(["ls", maybe_name]).return_code == 0:
            return maybe_name

    fail("Could not find source for: " + name)

def _get_sources(ctx, makefile_path, config_dict, prefix):
    '''Return a dict with keys:
      sources - the list of sources as configured for this rule
      x86asm - the list of x86 assembler files
    '''

    makefile_result = ctx.execute(["cat", makefile_path])
    if makefile_result.return_code != 0:
        return {
            "sources" : [],
            "x86asm" : [],
            "headers" : [],
        }

    makefile_contents = makefile_result.stdout
    make_dict = makefile_parse(makefile_contents)
    optional = _parse_optional(make_dict)
    optional_sources = flatten_config(optional, config_dict, prefix)
    fixed_sources = [
        prefix + x
        for x in _flatten([make_dict.get(x + "OBJS", [])
                           for x in CONFIG_PREFIXES.keys()])
        if x.find('$') == -1]

    all_sources = dict(
        [(_sourcify(ctx, x), None)
         for x in optional_sources + fixed_sources]).keys()

    return {
        "sources" : [x for x in all_sources if not x.endswith(".asm")],
        "x86asm" : [x for x in all_sources if x.endswith(".asm")],
        "headers" : [prefix + x for x in make_dict.get("HEADERS", [])],
    }


def _impl(repository_ctx):
    repository_ctx.download_and_extract(
        url = [
            "https://ffmpeg.org/releases/ffmpeg-3.4.2.tar.xz"
        ],
        sha256 = "2b92e9578ef8b3e49eeab229e69305f5f4cbc1fdaa22e927fc7fca18acccd740",
        stripPrefix = "ffmpeg-3.4.2",
    )

    patch(repository_ctx)

    modules = [
        "swresample",
        "swscale",
        "avutil",
        "avcodec",
        "avformat",
        "avfilter",
        "avdevice",
    ]

    substitutions = {}

    repository_ctx.symlink(
        repository_ctx.attr.config_h,
        "private/config.h.in",
    )

    config_h_lines = repository_ctx.execute(["cat", "private/config.h.in"]).stdout.split("\n")

    config_vars = config_h_lines[3:-1]
    config_dict = dict([(x, None) for x in config_vars])
    substitutions['@CONFIG_VARS@'] = _format_list(config_vars)
    asm_files = []

    substitutions['@MODULES@'] = _format_list(modules)

    for module in modules:
        prefix = "lib{}/".format(module)

        makefile_data = _get_sources(
            repository_ctx, "lib{}/Makefile".format(module),
            config_dict, prefix)

        substitutions["@{}_SOURCES@".format(module.upper())] = \
            _format_list(makefile_data["sources"])
        substitutions["@{}_HEADERS@".format(module.upper())] = \
            _format_list(makefile_data["headers"])

        if len(makefile_data["x86asm"]):
            fail("unexpected x86 assembler at the top level")

        # Now check for platform specific directories.
        for platform in ['arm', 'x86']:
            makefile_data = _get_sources(
                repository_ctx, "lib{}/{}/Makefile".format(module, platform),
                config_dict, prefix)

            platform_key_prefix = '@{}_{}_'.format(
                module.upper(), platform.upper())
            platform_key = platform_key_prefix + "SOURCES@"
            platform_x86asm = platform_key_prefix + "X86ASM@"

            substitutions[platform_key] = \
                _format_list(makefile_data["sources"])

            substitutions[platform_x86asm] = \
                _format_list(makefile_data["x86asm"])

            if len(makefile_data["headers"]):
                fail("unexpected headers in platform directory")

    _make_list(repository_ctx, config_dict,
               predicate = ["_ENCODER 1", "_DECODER 1"],
               header = 'static const AVCodec * const codec_list[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavcodec/codec_list.c")

    all_filters = [x.split(' ')[2].strip(';') for x in repository_ctx.execute(["cat", "libavfilter/allfilters.c"]).stdout.split("\n")
                   if x.startswith("extern AVFilter ff_")]
    configured_filters = [x for x in all_filters
                          if '#define CONFIG_{}_FILTER 1'.format(x.split('_', 2)[2].upper()) in config_dict]

    repository_ctx.file(
        "libavfilter/filter_list.c",
        content = '\n'.join(
            ['static const AVFilter * const filter_list[] = {'] + [
                '&{},'.format(x) for x in configured_filters] + [
                    'NULL };'])
    )

    _make_list(repository_ctx, config_dict,
               predicate = ["_PROTOCOL 1"],
               header = 'static const URLProtocol * const url_protocols[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavformat/protocol_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_PARSER 1"],
               header = 'static const AVCodecParser * const parser_list[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavcodec/parser_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_BSF 1"],
               header = 'static const AVBitStreamFilter * const bitstream_filters[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavcodec/bsf_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_MUXER 1"],
               header = 'static const AVOutputFormat * const muxer_list[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavformat/muxer_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_DEMUXER 1"],
               header = 'static const AVInputFormat * const demuxer_list[] = {',
               item = '&ff_{},',
               strip = " 1",
               output = "libavformat/demuxer_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_OUTDEV 1"],
               header = 'static const AVOutputFormat * const outdev_list[] = {',
               item = '&ff_{}_muxer,',
               strip = "_OUTDEV 1",
               output = "libavdevice/outdev_list.c")

    _make_list(repository_ctx, config_dict,
               predicate = ["_INDEV 1"],
               header = 'static const AVInputFormat * const indev_list[] = {',
               item = '&ff_{}_demuxer,',
               strip = "_INDEV 1",
               output = "libavdevice/indev_list.c")

    repository_ctx.template(
        "BUILD",
        repository_ctx.attr.build_file_template,
        substitutions = substitutions,
    )

_ffmpeg_repository = repository_rule(
    implementation = _impl,
    attrs = {
        "build_file_template" : attr.label(allow_single_file = True),
        "config_h" : attr.label(allow_single_file = True),
        "patches" : attr.label_list(default = []),
        "patch_tool" : attr.string(default = "patch"),
        "patch_args" : attr.string_list(default = ["-p0"]),
        "patch_cmds" : attr.string_list(default = []),
    },
)

def ffmpeg_repository(name):
    _ffmpeg_repository(
        name = name,
        build_file_template = Label("//tools/workspace/ffmpeg:package.BUILD"),
        config_h = Label("//tools/workspace/ffmpeg:config.h"),
        patches = [
            # From: https://patchwork.ffmpeg.org/patch/8253/
            Label("//tools/workspace/ffmpeg:using_dn_directive.diff"),
        ],
    )
