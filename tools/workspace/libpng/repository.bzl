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


def libpng_repository(name):
    http_archive(
        name = name,
        urls = [
            "http://prdownloads.sourceforge.net/libpng/libpng-1.6.35.tar.xz?download",
        ],
        sha256 = "23912ec8c9584917ed9b09c5023465d71709dce089be503c7867fec68a93bcd7",
        strip_prefix = "libpng-1.6.35",
        build_file = Label("//tools/workspace/libpng:package.BUILD"),
    )
