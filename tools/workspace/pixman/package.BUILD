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

load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")
load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")

package(default_visibility = ["//visibility:public"])

libpixman_sources = [
    "pixman.c",
    "pixman-access.c",
    "pixman-access-accessors.c",
    "pixman-bits-image.c",
    "pixman-combine32.c",
    "pixman-combine-float.c",
    "pixman-conical-gradient.c",
    "pixman-filter.c",
    "pixman-x86.c",
    "pixman-mips.c",
    "pixman-arm.c",
    "pixman-ppc.c",
    "pixman-edge.c",
    "pixman-edge-accessors.c",
    "pixman-fast-path.c",
    "pixman-glyph.c",
    "pixman-general.c",
    "pixman-gradient-walker.c",
    "pixman-image.c",
    "pixman-implementation.c",
    "pixman-linear-gradient.c",
    "pixman-matrix.c",
    "pixman-noop.c",
    "pixman-radial-gradient.c",
    "pixman-region16.c",
    "pixman-region32.c",
    "pixman-solid-fill.c",
    "pixman-timer.c",
    "pixman-trap.c",
    "pixman-utils.c",
]

libpixman_headers = [
    "pixman.h",
    "pixman-accessor.h",
    "pixman-combine32.h",
    "pixman-compiler.h",
    "pixman-edge-imp.h",
    "pixman-inlines.h",
    "pixman-private.h",
]

cc_library(
    name = "pixman",
    hdrs = ["pixman/" + x for x in libpixman_headers],
    srcs = ["pixman/" + x for x in libpixman_sources] + [
        "private/config.h",
        "pixman/pixman-version.h",
    ],
    textual_hdrs = [
        "pixman/pixman-access.c",
        "pixman/pixman-region.c",
        "pixman/pixman-edge.c",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/pixman/private",
        "-Wno-unused-local-typedefs",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:clang" : [
            "-Wno-unused-const-variable",
            "-Wno-tautological-constant-out-of-range-compare",
        ],
        "//conditions:default" : [],
    }),
    includes = ["pixman"],
)

template_file(
    name = "pixman/pixman-version.h",
    src = "pixman/pixman-version.h.in",
    substitutions = {
        "@PIXMAN_VERSION_MAJOR@" : "0",
        "@PIXMAN_VERSION_MINOR@" : "34",
        "@PIXMAN_VERSION_MICRO@" : "1",
    },
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "pixman",
    version = "0.34.0",
    defines = autoconf_standard_defines + [
        "TLS=__thread",
        "TOOLCHAIN_SUPPORTS_ATTRIBUTE_CONSTRUCTOR",
        # "USE_GCC_INLINE_ASM",
    ],
)
