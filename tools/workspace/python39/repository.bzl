# -*- python -*-

# Copyright 2018-2021 Josh Pieper, jjp@pobox.com.
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


def python39_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tar.xz",
        ],
        sha256 = "06828c04a573c073a4e51c4292a27c1be4ae26621c3edc7cf9318418ce3b6d27",
        strip_prefix = "Python-3.9.9",
        build_file = Label("//tools/workspace/python39:package.BUILD"),
    )
