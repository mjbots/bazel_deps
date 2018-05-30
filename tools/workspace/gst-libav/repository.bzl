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


def gst_libav_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.14.1.tar.xz",
        ],
        sha256 = "eff80a02d2f2fb9f34b67e9a26e9954d3218c7aa18e863f2a47805fa7066029d",
        strip_prefix = "gst-libav-1.14.1",
        build_file = Label("//tools/workspace/gst-libav:package.BUILD"),
        patches = [Label("//tools/workspace/gst-libav:fix.patch")],
    )
