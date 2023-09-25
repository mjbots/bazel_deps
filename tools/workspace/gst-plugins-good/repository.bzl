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


def gst_plugins_good_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.14.1.tar.xz",
        ],
        sha256 = "34ec062ddb766a32377532e039781f4a16fbc3e8b449e642605bacab26a99172",
        strip_prefix = "gst-plugins-good-1.14.1",
        build_file = Label("//tools/workspace/gst-plugins-good:package.BUILD"),
    )
