# -*- python -*-

# Copyright 2020 Josh Pieper, jjp@pobox.com.
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

package(default_visibility = ["//visibility:public"])

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

generate_file(
    name = "src/ccd/config.h",
    content = """
#ifndef __CCD_CONFIG_H__
#define __CCD_CONFIG_H__

#define CCD_DOUBLE

#endif
    """)

cc_library(
    name = "libccd",
    hdrs = glob(["src/ccd/*.h"]) + ["src/ccd/config.h"],
    srcs = glob(["src/*.c", "src/*.h"]),
    includes = ["src"],
)
