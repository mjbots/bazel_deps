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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def _impl(repository_ctx):
    version = repository_ctx.attr.version
    sha256 = repository_ctx.attr.sha256
    repository_ctx.download_and_extract(
        url = [
            "https://github.com/opencv/opencv/archive/{}.tar.gz".format(version),
        ],
        sha256 = sha256,
        stripPrefix = "opencv-{}".format(version),
    )

    contrib_sha256 = repository_ctx.attr.contrib_sha256
    repository_ctx.download_and_extract(
        url = [
            "https://github.com/opencv/opencv_contrib/archive/{}.tar.gz".format(version),
        ],
        sha256 = contrib_sha256,
        stripPrefix = "opencv_contrib-{}".format(version),
    )

    substitutions = {
        '@PROCESSOR_OPTS@' : str(repository_ctx.attr.config.get('opts', [])),
    }

    repository_ctx.template(
        "BUILD",
        repository_ctx.attr.build_file_template,
        substitutions = substitutions,
    )

_opencv_repository = repository_rule(
    implementation = _impl,
    attrs = {
        "build_file_template" : attr.label(allow_single_file = True),
        "config" : attr.string_list_dict(),
        "version" : attr.string(default = "3.4.2"),
        "sha256" : attr.string(default = "81dbd5e7e9f8a4c936b94629bf4765745942a1d634ae38ec08bc57b73b28ffc5"),
        "contrib_sha256" : attr.string(default = "45a52764ebd2558fa0b7fd8dc47379b37dd0956d912abbf7c786228374fdf60d"),
    }
)

def opencv_repository(name, config=None, **kwargs):
    _opencv_repository(
        name = name,
        build_file_template = Label("//tools/workspace/opencv:package.BUILD"),
        config = config or {},
        **kwargs
    )
