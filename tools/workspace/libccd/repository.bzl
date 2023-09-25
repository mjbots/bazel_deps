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

load("//tools/workspace:github_archive.bzl", "github_archive")

def libccd_repository(name):
    github_archive(
        name = name,
        repo = "danfis/libccd",
        commit = "7931e764a19ef6b21b443376c699bbc9c6d4fba8",
        sha256 = "e884eed4359f25ca714ce9ea8fc1ae965c5ce8652cf1444c1c6598fd9bc6faf4",
        build_file = Label("//tools/workspace/libccd:package.BUILD"),
    )
