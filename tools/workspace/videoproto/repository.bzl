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


def videoproto_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/proto/videoproto-2.3.3.tar.bz2",
        ],
        sha256 = "c7803889fd08e6fcaf7b68cc394fb038b2325d1f315e571a6954577e07cca702",
        strip_prefix = "videoproto-2.3.3",
        build_file = Label("//tools/workspace/videoproto:package.BUILD"),
    )
