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

def dart_repository(name):
    github_archive(
        name = name,
        repo = "dartsim/dart",
        commit = "29c0e51e615b588453733f526cb00a57dc73f77d",
        sha256 = "176a72ded5e9eff7e839d3604f5197c2a1417fa70956e5b8a5de61a928ca5a9b",
        build_file = Label("//tools/workspace/dart:package.BUILD"),
        patches = [
            Label("//tools/workspace/dart:opengl_types.patch"),
        ],
        patch_args = ["-p1"],
    )
