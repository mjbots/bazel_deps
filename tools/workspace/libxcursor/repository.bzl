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


def libxcursor_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/lib/libXcursor-1.2.0.tar.bz2",
        ],
        sha256 = "3ad3e9f8251094af6fe8cb4afcf63e28df504d46bfa5a5529db74a505d628782",
        strip_prefix = "libXcursor-1.2.0",
        build_file = Label("//tools/workspace/libxcursor:package.BUILD"),
    )
