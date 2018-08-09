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

load("@com_github_mjbots_bazel_deps//tools/workspace:makefile.bzl", "makefile_parse", "format_makefile")

def _impl(repository_ctx):
    repository_ctx.download_and_extract(
        url = [
            "https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.8.7.tar.bz2"
        ],
        sha256 = "96e0c8ac6fd25da783052f0b65f2f0314e6a63af94e87ca127ae2d8e39306453",
        stripPrefix = "harfbuzz-1.8.7",
    )

    Makefile_sources = makefile_parse(repository_ctx.execute(
        ["cat", "src/Makefile.sources"]).stdout)
    ucdn_sources = makefile_parse(repository_ctx.execute(
        ["cat", "src/hb-ucdn/Makefile.sources"]).stdout)

    Makefile_sources.update({"LIBHB_UCDN_sources" : ["hb-ucdn/" + x for x in ucdn_sources["LIBHB_UCDN_sources"]]})

    repository_ctx.file("WORKSPACE", "workspace(name = \"{name}\")\n".format(name = repository_ctx.name))

    repository_ctx.template(
        "BUILD",
        repository_ctx.attr.build_file_template,
        substitutions = {
            "@MAKEFILE_SOURCES@" : format_makefile(Makefile_sources),
        })

_harfbuzz_repository = repository_rule(
    implementation = _impl,
    attrs = {
        "build_file_template" : attr.label(allow_single_file=True),
    },
)

def harfbuzz_repository(name):
    _harfbuzz_repository(
        name = name,
        build_file_template = Label("//tools/workspace/harfbuzz:package.BUILD"),
    )
