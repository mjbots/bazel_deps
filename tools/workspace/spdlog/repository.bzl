# -*- python -*-

# Copyright 2019 Josh Pieper, jjp@pobox.com.
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


def spdlog_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://github.com/gabime/spdlog/archive/v1.3.1.zip",
        ],
        sha256 = "db6986d0141546d4fba5220944cc1f251bd8afdfc434bda173b4b0b6406e3cd0",
        strip_prefix = "spdlog-1.3.1",
        build_file = Label("//tools/workspace/spdlog:package.BUILD"),
    )
