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


def freeglut_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://downloads.sourceforge.net/freeglut/freeglut-2.8.1.tar.gz",
        ],
        sha256 = "dde46626a62a1cd9cf48a11951cdd592e7067c345cffe193a149dfd47aef999a",
        strip_prefix = "freeglut-2.8.1",
        build_file = Label("//tools/workspace/freeglut:package.BUILD"),
    )
