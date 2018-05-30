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


def fontconfig_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.bz2",
        ],
        sha256 = "91dde8492155b7f34bb95079e79be92f1df353fcc682c19be90762fd3e12eeb9",
        strip_prefix = "fontconfig-2.13.0",
        build_file = Label("//tools/workspace/fontconfig:package.BUILD"),
    )
