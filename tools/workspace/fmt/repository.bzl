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


def fmt_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/fmtlib/fmt/archive/5.0.0.tar.gz",
        ],
        sha256 = "fc33d64d5aa2739ad2ca1b128628a7fc1b7dca1ad077314f09affc57d59cf88a",
        strip_prefix = "fmt-5.0.0",
        build_file = Label("//tools/workspace/fmt:package.BUILD"),
    )
