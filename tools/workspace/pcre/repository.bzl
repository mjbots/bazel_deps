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


def pcre_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.bz2",
        ],
        sha256 = "2cd04b7c887808be030254e8d77de11d3fe9d4505c39d4b15d2664ffe8bf9301",
        strip_prefix = "pcre-8.42",
        build_file = Label("//tools/workspace/pcre:package.BUILD"),
    )
