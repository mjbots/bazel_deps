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


def gst_rtsp_server_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-1.14.1.tar.xz",
        ],
        sha256 = "38634f3b25c2bf2967b1ff914b54ff384f8612f5aefc18accd72c78bf3b02d7c",
        strip_prefix = "gst-rtsp-server-1.14.1",
        build_file = Label("//tools/workspace/gst-rtsp-server:package.BUILD"),
    )
