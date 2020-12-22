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


def libxcb_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/xcb/libxcb-1.14.tar.xz",
        ],
        sha256 = "a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34",
        strip_prefix = "libxcb-1.14",
        build_file = Label("//tools/workspace/libxcb:package.BUILD"),
    )
