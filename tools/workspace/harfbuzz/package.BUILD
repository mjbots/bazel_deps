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
load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")

package(default_visibility = ["//visibility:public"])

@MAKEFILE_SOURCES@

HBSOURCES = (
    HB_BASE_sources +
    HB_BASE_RAGEL_GENERATED_sources +
    HB_OT_sources +
    HB_OT_RAGEL_GENERATED_sources +
    HB_FALLBACK_sources +
    HB_FT_sources +
    HB_GLIB_sources +
    HB_UCDN_sources +
    LIBHB_UCDN_sources)
HBHEADERS = (
    HB_BASE_headers +
    HB_OT_headers +
    HB_FT_headers +
    HB_GLIB_headers)

COMMON_COPTS = [
    "-I$(GENDIR)/external/harfbuzz/harfbuzzprivate",
    "-fpermissive",
    "-DHAVE_CONFIG_H",
    "-DHAVE_UCDN",
    "-DHB_NO_MT",
]

COMMON_SRCS = [
    "harfbuzzprivate/config.h",
]

HBSOURCES_headers = [x for x in HBSOURCES if x.endswith(".hh")]

cc_library(
    name = "harfbuzz_subset",
    srcs = ["src/" + x for x in HB_SUBSET_sources + HBSOURCES_headers + ["hb-version.h"]] + COMMON_SRCS,
    hdrs = ["src/" + x for x in HB_SUBSET_headers + HBHEADERS],
    copts = COMMON_COPTS,
    includes = ["src", "src/hb-ucdn"],
)

cc_library(
    name = "harfbuzz",
    hdrs = ["src/" + x for x in HBHEADERS],
    srcs = ["src/" + x for x in HBSOURCES + HB_SUBSET_headers] + COMMON_SRCS,
    copts = COMMON_COPTS,
    includes = ["src", "src/hb-ucdn"],
    deps = ["@glib", "@freetype"],
)

template_file(
    name = "src/hb-version.h",
    src = "src/hb-version.h.in",
    substitutions = {
        "@HB_VERSION_MAJOR@" : "1",
        "@HB_VERSION_MINOR@" : "8",
        "@HB_VERSION_MICRO@" : "1",
        "@HB_VERSION@" : "\\\"1.8.1\\\"",
    },
)

autoconf_config(
    name = "harfbuzzprivate/config.h",
    src = "config.h.in",
    package = "harfbuzz",
    version = "1.8.1",
    defines = autoconf_standard_defines + [
        "HAVE_FREETYPE",
        "HAVE_FT_DONE_MM_VAR",
        "HAVE_FT_GET_VAR_BLEND_COORDINATES",
        "HAVE_FT_SET_VAR_BLEND_COORDINATES",
        "HAVE_GLIB",
    ],
)
