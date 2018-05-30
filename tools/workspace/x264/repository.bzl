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


def x264_repository(name):
    http_archive(
        name = name,
        urls = [
            "http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20180611-2245.tar.bz2",
        ],
        sha256 = "1b2a2f9a364949faebd0b1c3d49fb34162cd8e5d39a2fe2fc66cee1ac540cf09",
        strip_prefix = "x264-snapshot-20180611-2245",
        build_file = Label("//tools/workspace/x264:package.BUILD"),
    )
