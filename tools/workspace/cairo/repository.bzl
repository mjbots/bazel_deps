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


def cairo_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://cairographics.org/releases/cairo-1.14.12.tar.xz",
        ],
        sha256 = "8c90f00c500b2299c0a323dd9beead2a00353752b2092ead558139bd67f7bf16",
        strip_prefix = "cairo-1.14.12",
        build_file = Label("//tools/workspace/cairo:package.BUILD"),
    )
