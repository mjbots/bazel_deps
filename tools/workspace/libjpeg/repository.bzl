# -*- python -*-

# Copyright 2018-2019 Josh Pieper, jjp@pobox.com.
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


def libjpeg_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://downloads.sourceforge.net/project/libjpeg/libjpeg/6b/jpegsrc.v6b.tar.gz",
        ],
        sha256 = "75c3ec241e9996504fe02a9ed4d12f16b74ade713972f3db9e65ce95cd27e35d",
        strip_prefix = "jpeg-6b",
        build_file = Label("//tools/workspace/libjpeg:package.BUILD"),
    )
