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

fribidi_headers = ["lib/" + x for x in [
    'fribidi-arabic.h',
    'fribidi-begindecls.h',
    'fribidi-bidi.h',
    'fribidi-bidi-types.h',
    'fribidi-bidi-types-list.h',
    'fribidi-char-sets.h',
    'fribidi-char-sets-list.h',
    'fribidi-common.h',
    'fribidi-deprecated.h',
    'fribidi-enddecls.h',
    'fribidi-flags.h',
    'fribidi-joining.h',
    'fribidi-joining-types.h',
    'fribidi-joining-types-list.h',
    'fribidi-mirroring.h',
    'fribidi-brackets.h',
    'fribidi-shape.h',
    'fribidi-types.h',
    'fribidi-unicode.h',
    'fribidi.h',
]]

fribidi_sources = ["lib/" + x for x in [
    'fribidi.c',
    'fribidi-arabic.c',
    'fribidi-bidi.c',
    'fribidi-bidi-types.c',
    'fribidi-char-sets.c',
    'fribidi-char-sets-cap-rtl.c',
    'fribidi-char-sets-cp1255.c',
    'fribidi-char-sets-cp1256.c',
    'fribidi-char-sets-iso8859-6.c',
    'fribidi-char-sets-iso8859-8.c',
    'fribidi-char-sets-utf8.c',
    'fribidi-char-sets-utf8.h',
    'fribidi-deprecated.c',
    'fribidi-joining.c',
    'fribidi-joining-types.c',
    'fribidi-mirroring.c',
    'fribidi-brackets.c',
    'fribidi-run.c',
    'fribidi-shape.c',
    'common.h',
    'debug.h',
    'run.h',
    'bidi-types.h',
    'joining-types.h',
    'fribidi-char-sets-cap-rtl.h',
    'fribidi-char-sets-cp1255.h',
    'fribidi-char-sets-cp1256.h',
    'fribidi-char-sets-iso8859-6.h',
    'fribidi-char-sets-iso8859-8.h',
    'fribidi-unicode-version.h',
]]


cc_library(
    name = "fribidi",
    includes = [".", "lib"],
    hdrs = fribidi_headers,
    srcs = fribidi_sources + [
        "lib/fribidi-config.h",
        "private/config.h",
    ],
    textual_hdrs = glob(["lib/*.tab.i"]),
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/fribidi/private",
        "-I$(GENDIR)/external/fribidi",
        "-I$(GENDIR)/external/fribidi/lib",
        "-Iexternal/fribidi/lib",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:clang" : [
            "-Wno-enum-conversion",
        ],
        "//conditions:default" : [],
    }),
)

template_file(
    name = "lib/fribidi-config.h",
    src = "lib/fribidi-config.h.in",
    substitutions = {
        "@PACKAGE@" : "fribidi",
        "@PACKAGE_NAME@" : "fribidi",
        "@PACKAGE_BUGREPORT@" : "",
        "@FRIBIDI_VERSION@" : "1.0.4",
        "@FRIBIDI_MAJOR_VERSION@" : "1",
        "@FRIBIDI_MINOR_VERSION@" : "0",
        "@FRIBIDI_MICRO_VERSION@" : "4",
        "@FRIBIDI_INTERFACE_VERSION@" : "4",
        "@SIZEOF_INT@" : "4",
        "@FRIBIDI_MSVC_BUILD_PLACEHOLDER@" : "",
    },
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "fribidi",
    version = "1.0.4",
    defines = autoconf_standard_defines + [
        "RETSIGTYPE=void",
    ],
)
