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


def xorgproto_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://www.x.org/releases/individual/proto/xorgproto-2022.2.tar.xz",
        ],
        sha256 = "5d13dbf2be08f95323985de53352c4f352713860457b95ccaf894a647ac06b9e",
        strip_prefix = "xorgproto-2022.2",
        build_file = Label("//tools/workspace/xorgproto:package.BUILD"),
    )
