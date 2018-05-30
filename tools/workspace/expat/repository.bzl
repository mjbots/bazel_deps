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


def expat_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/libexpat/libexpat/releases/download/R_2_2_5/expat-2.2.5.tar.bz2",
        ],
        sha256 = "d9dc32efba7e74f788fcc4f212a43216fc37cf5f23f4c2339664d473353aedf6",
        strip_prefix = "expat-2.2.5",
        build_file = Label("//tools/workspace/expat:package.BUILD"),
    )
