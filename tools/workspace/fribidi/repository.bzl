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


def fribidi_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/fribidi/fribidi/releases/download/v1.0.4/fribidi-1.0.4.tar.bz2",
        ],
        sha256 = "94bdfe553e004d8bd095b109e182682311dd511740d5083326d1582f1df237be",
        strip_prefix = "fribidi-1.0.4",
        build_file = Label("//tools/workspace/fribidi:package.BUILD"),
    )
