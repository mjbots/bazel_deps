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


def boost_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://managedway.dl.sourceforge.net/project/boost/boost/1.73.0/boost_1_73_0.tar.bz2",
            "https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2",
        ],
        sha256 = "4eb3b8d442b426dc35346235c8733b5ae35ba431690e38c6a8263dce9fcbb402",
        strip_prefix = "boost_1_73_0",
        build_file = Label("//tools/workspace/boost:package.BUILD"),
    )
