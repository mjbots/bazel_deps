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

load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "snappy",
    hdrs = [
        "snappy-c.h",
        "snappy.h",
        "snappy-internal.h",
        "snappy-sinksource.h",
        "snappy-stubs-internal.h",
        "snappy-stubs-public.h",
    ],
    srcs = [
        "snappy.cc",
        "snappy-c.cc",
        "snappy-sinksource.cc",
        "snappy-stubs-internal.cc",
    ],
    includes = ["."],
    copts = [
        "-Wno-sign-compare",
        "-Wno-unused-parameter",
    ],
)

template_file(
    name = "snappy-stubs-public.h",
    src = "snappy-stubs-public.h.in",
    substitution_list = select({
        "@bazel_tools//src/conditions:windows": [
            "${HAVE_SYS_UIO_H_01}=0",
        ],
        "//conditions:default": [
            "${HAVE_SYS_UIO_H_01}=1",
        ]
    }) + [
        "${HAVE_STDINT_H_01}=1",
        "${HAVE_STDDEF_H_01}=1",
        "${SNAPPY_MAJOR}=1",
        "${SNAPPY_MINOR}=1",
        "${SNAPPY_PATCHLEVEL}=7",
    ],
)
