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
            "https://managedway.dl.sourceforge.net/project/boost/boost/1.72.0/boost_1_72_0.tar.bz2",
            "https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.bz2",
        ],
        sha256 = "59c9b274bc451cf91a9ba1dd2c7fdcaf5d60b1b3aa83f2c9fa143417cc660722",
        strip_prefix = "boost_1_72_0",
        build_file = Label("//tools/workspace/boost:package.BUILD"),
    )
