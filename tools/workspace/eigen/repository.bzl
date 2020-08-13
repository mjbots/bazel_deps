# -*- python -*-

# Copyright 2018-2020 Josh Pieper, jjp@pobox.com.
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


def eigen_repository(name):
    http_archive(
        name = name,
        urls = [
            # A mirror to work around https://github.com/bazelbuild/bazel/issues/11187
            "https://gist.github.com/jpieper/c56eb4c35283608d5f568ba26ff95067/raw/e0832f8784968ce475839da8cb76227828934dc8/eigen-99da2e1a8da4130279aa3becd6c23be0181edb07.tar.bz2",
            "https://gitlab.com/libeigen/eigen/-/archive/99da2e1a8da4130279aa3becd6c23be0181edb07/eigen-99da2e1a8da4130279aa3becd6c23be0181edb07.tar.bz2",
        ],
        sha256 = "9089a59ed90a873c3e71c0c1e94004d5768ad518764a4f844cbba5df4285b6b5",
        strip_prefix = "eigen-99da2e1a8da4130279aa3becd6c23be0181edb07",
        build_file = Label("//tools/workspace/eigen:package.BUILD"),
    )
