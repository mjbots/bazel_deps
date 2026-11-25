# -*- python -*-

# Copyright 2023 mjbots Robotic Systems, LLC.  info@mjbots.com
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


def python314_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.python.org/ftp/python/3.14.10/Python-3.14.10.tar.xz",
        ],
        sha256 = "de414a57119abef52784d8993e341d53aed635fc2b05c2607d9f98a2c5b72032",
        strip_prefix = "Python-3.14.10",
        build_file = Label("//tools/workspace/python314:package.BUILD"),
    )
