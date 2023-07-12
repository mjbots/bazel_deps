# -*- python -*-

# Copyright 2018-2023 Josh Pieper, jjp@pobox.com.
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


def python310_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tar.xz",
        ],
        sha256 = "afb74bf19130e7a47d10312c8f5e784f24e0527981eab68e20546cfb865830b8",
        strip_prefix = "Python-3.10.12",
        build_file = Label("//tools/workspace/python310:package.BUILD"),
    )
