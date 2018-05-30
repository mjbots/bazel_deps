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


def libffi_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/libffi/libffi/releases/download/v3.3-rc0/libffi-3.3-rc0.tar.gz",
        ],
        sha256 = "403d67aabf1c05157855ea2b1d9950263fb6316536c8c333f5b9ab1eb2f20ecf",
        strip_prefix = "libffi-3.3-rc0",
        build_file = Label("//tools/workspace/libffi:package.BUILD"),
    )
