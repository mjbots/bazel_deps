# -*- python -*-

# Copyright 2020 Josh Pieper, jjp@pobox.com.
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


def libxi_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/lib/libXi-1.7.10.tar.bz2",
        ],
        sha256 = "36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061",
        strip_prefix = "libXi-1.7.10",
        build_file = Label("//tools/workspace/libxi:package.BUILD"),
    )
