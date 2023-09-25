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

def log4cpp_repository(name):
    sha256 = None

    repo = "mjbots/log4cpp"
    commit = "0a9fb3d662c79b9480eb150c9b7ee3f4d87a6b08"
    sha256 = "9015971c72eeb5d98eee1d99fc379b9be04e8503443f22e8db588b364c1721c4"

    http_archive(
        name = name,
        url = "https://github.com/{repo}/archive/{commit}.zip".format(
            repo=repo, commit=commit),
        strip_prefix = "{}-{}".format(repo.rsplit('/', 1)[-1], commit),
        sha256 = sha256 or "0000000000000000000000000000000000000000000000000000000000000000",
        build_file = Label("//tools/workspace/log4cpp:package.BUILD"),
    )
