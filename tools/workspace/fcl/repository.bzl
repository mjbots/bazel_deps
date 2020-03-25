# -*- python -*-

# Copyright 2020 Josh Pieper, jjp@pobox.com.
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

load("//tools/workspace:github_archive.bzl", "github_archive")

def fcl_repository(name):
    github_archive(
        name = name,
        repo = "flexible-collision-library/fcl",
        commit = "97455a46de121fb7c0f749e21a58b1b54cd2c6be",
        sha256 = "4755ad0619a6d37f18167ccf27d8ea58fb6a2566fec5359e446297a9f4065b2c",
        build_file = Label("//tools/workspace/fcl:package.BUILD"),
    )
