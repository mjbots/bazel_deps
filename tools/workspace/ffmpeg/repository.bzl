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
            if extension == ".asm":
                # we have these handled by a special rule, just look
                # for the .o file.
                return name

            return maybe_name

    fail("Could not find source for: " + name)

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
        "avresample",
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

    for module in modules:
        prefix = "lib{}/".format(module)

        makefile = repository_ctx.execute(["cat", "lib{}/Makefile".format(module)]).stdout
        make_dict = makefile_parse(makefile)
        optional = _parse_optional(make_dict)
        optional_sources = flatten_config(optional, config_dict, prefix)
        fixed_sources = [
            prefix + x
            for x in _flatten([make_dict.get(x + "OBJS", []) for x in CONFIG_PREFIXES.keys()])
            if x.find('$') == -1]

        all_sources = dict(
            [(_sourcify(repository_ctx, x), None)
             for x in optional_sources + fixed_sources]).keys()
        asm_files += [x for x in all_sources if x.endswith(".o")]

        substitutions['@{}_SOURCES@'.format(module.upper())] = _format_list(all_sources)
        substitutions['@{}_HEADERS@'.format(module.upper())] = (
            _format_list([prefix + x
                          for x in make_dict.get('HEADERS', [])]))

        # Now check for platform specific directories.
        for platform in ['arm', 'x86']:
            platform_key = '@{}_{}_SOURCES@'.format(
                module.upper(), platform.upper())
            platform_makefile_result = repository_ctx.execute(
                ["cat", "lib{}/{}/Makefile".format(module, platform)])
            if platform_makefile_result.return_code != 0:
                substitutions[platform_key] = "[]"
                continue
            platform_makefile = platform_makefile_result.stdout
            platform_dict = makefile_parse(platform_makefile)
            platform_optional = _parse_optional(platform_dict)
            platform_optional_sources = flatten_config(
                platform_optional, config_dict, prefix)

            platform_fixed_sources = [
                prefix + x
                for x in _flatten([platform_dict.get(x + "OBJS", []) for x in CONFIG_PREFIXES.keys()])
                if x.find('$') == -1]

            platform_first_sources = dict(
                [(_sourcify(repository_ctx, x), None)
                 for x in platform_optional_sources + platform_fixed_sources]).keys()
            platform_all_sources = [x for x in platform_first_sources
                                    if not x.endswith(".o")]

            asm_files += [x for x in platform_first_sources if x.endswith(".o")]

            substitutions[platform_key] = _format_list(platform_all_sources)

    substitutions["@ASM_FILES@"] = _format_list(
        [x.replace(".o", ".asm") for x in asm_files])

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
