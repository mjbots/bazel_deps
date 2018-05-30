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


def pixman_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.cairographics.org/releases/pixman-0.34.0.tar.gz",
        ],
        sha256 = "21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e",
        strip_prefix = "pixman-0.34.0",
        build_file = Label("//tools/workspace/pixman:package.BUILD"),
    )
