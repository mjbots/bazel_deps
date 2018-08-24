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

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "libpng",
    hdrs = [
        "pngconf.h",
        "pngdebug.h",
        "png.h",
        "pnginfo.h",
        "pngpriv.h",
        "pngstruct.h",

        "pnglibconf.h",
    ],
    include_prefix = "libpng",
    srcs = [
        "pngconf.h",
        "pngdebug.h",
        "png.h",
        "pnginfo.h",
        "pngpriv.h",
        "pngstruct.h",

        "pnglibconf.h",

        "private/config.h",

        "png.c",
        "pngerror.c",
        "pngget.c",
        "pngmem.c",
        "pngpread.c",
        "pngread.c",
        "pngrio.c",
        "pngrtran.c",
        "pngrutil.c",
        "pngset.c",
        "pngtrans.c",
        "pngwio.c",
        "pngwrite.c",
        "pngwtran.c",
        "pngwutil.c",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
            "arm/arm_init.c",
            "arm/filter_neon.S",
            "arm/filter_neon_intrinsics.c",
        ],
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "intel/filter_sse2_intrinsics.c",
            "intel/intel_init.c",
        ],
    }),
    includes = ["."],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/libpng/private",
    ],
    deps = ["@zlib"],
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "libpng",
    version = "1.6.35",
    defines = autoconf_standard_defines + select({
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
            "PNG_ARM_NEON_OPT=0",
        ],
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "PNG_INTEL_SSE_OPT",
        ],
    }),
)

genrule(
    name = "pnglibconf",
    srcs = ["scripts/pnglibconf.h.prebuilt"],
    outs = ["pnglibconf.h"],
    cmd = "cp $< $@",
)
