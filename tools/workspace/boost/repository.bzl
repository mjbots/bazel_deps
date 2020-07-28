# -*- python -*-

# Copyright 2018-2020 Josh Pieper, jjp@pobox.com.
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
#            "https://managedway.dl.sourceforge.net/project/boost/boost/1.74.0.beta.1/boost_1_74_0_b1.tar.bz2",
            "https://dl.bintray.com/boostorg/beta/1.74.0.beta.1/source/boost_1_74_0_b1.tar.bz2",
        ],
        sha256 = "ba09c72dc848e7c0904922967014d853897b5a634926c910cc3b1fd627c31605",
        strip_prefix = "boost_1_74_0",
        build_file = Label("//tools/workspace/boost:package.BUILD"),
    )
