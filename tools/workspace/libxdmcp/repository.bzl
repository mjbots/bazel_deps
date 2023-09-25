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


def libxdmcp_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/lib/libXdmcp-1.1.2.tar.bz2",
        ],
        sha256 = "81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2",
        strip_prefix = "libXdmcp-1.1.2",
        build_file = Label("//tools/workspace/libxdmcp:package.BUILD"),
    )
