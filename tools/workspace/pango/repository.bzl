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


def pango_repository(name):
    http_archive(
        name = name,
        urls = [
            "http://ftp.gnome.org/pub/GNOME/sources/pango/1.42/pango-1.42.1.tar.xz",
        ],
        sha256 = "915a6756b298578ff27c7a6393f8c2e62e6e382f9411f2504d7af1a13c7bce32",
        strip_prefix = "pango-1.42.1",
        build_file = Label("//tools/workspace/pango:package.BUILD"),
    )
