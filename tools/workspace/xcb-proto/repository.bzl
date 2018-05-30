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


def xcb_proto_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/xcb/xcb-proto-1.13.tar.bz2",
        ],
        sha256 = "7b98721e669be80284e9bbfeab02d2d0d54cd11172b72271e47a2fe875e2bde1",
        strip_prefix = "xcb-proto-1.13",
        build_file = Label("//tools/workspace/xcb-proto:package.BUILD"),
    )
