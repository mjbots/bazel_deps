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

load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")

package(default_visibility = ["//visibility:public"])

autoconf_config(
    name = "config.h",
    src = "config.h.in",
    package = "freeglut",
    version = "2.8.1",
    defines = autoconf_standard_defines,
)

cc_library(
    name = "freeglut",
    hdrs = [
        "config.h",
    ] + glob(["include/GL/*.h"]),
    srcs = glob([
        "src/*.c",
        "src/*.h",
    ]),
    copts = [
        "-DHAVE_CONFIG_H",
        "-Wno-unused-const-variable",
        "-Wno-unused-variable",
        "-Wno-int-to-pointer-cast",
        "-Wno-unused-function",
        "-Wno-pointer-to-int-cast",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:gcc" : [
            "-Wno-unused-but-set-variable",
        ],
        "//conditions:default" : [],
    }),
    includes = ["include"],
    deps = [
        "@libx11",
    ],
)
