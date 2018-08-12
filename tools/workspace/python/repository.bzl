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


def python_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz",
        ],
        sha256 = "f434053ba1b5c8a5cc597e966ead3c5143012af827fd3f0697d21450bb8d87a6",
        strip_prefix = "Python-3.6.5",
        patches = [Label("//tools/workspace/python:runfiles.patch")],
        build_file = Label("//tools/workspace/python:package.BUILD"),
    )
