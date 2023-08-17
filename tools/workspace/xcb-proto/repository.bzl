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


def xcb_proto_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/xcb/xcb-proto-1.15.tar.xz",
        ],
        sha256 = "d34c3b264e8365d16fa9db49179cfa3e9952baaf9275badda0f413966b65955f",
        strip_prefix = "xcb-proto-1.15",
        build_file = Label("//tools/workspace/xcb-proto:package.BUILD"),
    )
