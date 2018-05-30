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


def util_linux_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.32/util-linux-2.32.tar.xz",
        ],
        sha256 = "6c7397abc764e32e8159c2e96042874a190303e77adceb4ac5bd502a272a4734",
        strip_prefix = "util-linux-2.32",
        build_file = Label("//tools/workspace/util-linux:package.BUILD"),
    )
