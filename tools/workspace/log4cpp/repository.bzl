# -*- python -*-

# Copyright 2018-2019 Josh Pieper, jjp@pobox.com.
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
    commit = "118e6b347b00bad11774801d13acb31be8b2b527"
    sha256 = "3e92628d4633ace272eb5ce375fe7e72792a9a9acf2a9c238c93aab2e11da6b4"

    http_archive(
        name = name,
        url = "https://github.com/{repo}/archive/{commit}.zip".format(
            repo=repo, commit=commit),
        strip_prefix = "{}-{}".format(repo.rsplit('/', 1)[-1], commit),
        sha256 = sha256 or "0000000000000000000000000000000000000000000000000000000000000000",
        build_file = Label("//tools/workspace/log4cpp:package.BUILD"),
    )
