# -*- python -*-

# Copyright 2018-2021 Josh Pieper, jjp@pobox.com.
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
load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")
load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "headers",
    hdrs = glob(["Include/*.h", "Include/cpython/*.h"]) + ["Include/pyconfig.h"],
    includes = ["Include"],
)

autoconf_config(
    name = "Include/pyconfig.h",
    src = "pyconfig.h.in",
    package = "python",
    version = "3.9.9",
    defines = autoconf_standard_defines + [
        "DOUBLE_IS_LITTLE_ENDIAN_IEEE754",
        "ENABLE_IPV6",
        "PY_FORMAT_SIZE_T=\"z\"",
        "RETSIGTYPE=void",
        "USE_INLINE",
        "WITH_DOC_STRINGS",
        "WITH_THREAD",
        "_FILE_OFFSET_BITS=64",
        "_LARGEFILE_SOURCE",
    ],
)
