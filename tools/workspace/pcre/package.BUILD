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

cc_library(
    name = "pcre",
    hdrs = [
        "pcre.h",
    ],
    srcs = [
        "pcre_byte_order.c",
        "pcre_chartables.c",
        "pcre_compile.c",
        "pcre_config.c",
        "pcre_dfa_exec.c",
        "pcre_exec.c",
        "pcre_fullinfo.c",
        "pcre_get.c",
        "pcre_globals.c",
        "pcre_jit_compile.c",
        "pcre_maketables.c",
        "pcre_newline.c",
        "pcre_ord2utf8.c",
        "pcre_refcount.c",
        "pcre_string_utils.c",
        "pcre_study.c",
        "pcre_tables.c",
        "pcre_ucd.c",
        "pcre_valid_utf8.c",
        "pcre_version.c",
        "pcre_xclass.c",

        "pcrecpp.h",
        "pcrecpp_internal.h",
        "pcre_internal.h",
        "pcreposix.h",
        "pcre_scanner.h",
        "ucp.h",

        "pcreprivate/config.h",
    ],
    includes = ["."],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/pcre/pcreprivate",
        "-Wno-unused-const-variable",
        "-Wno-self-assign",
    ],
)

template_file(
    name = "pcre.h",
    src = "pcre.h.in",
    substitutions = {
        "@PCRE_MAJOR@" : "8",
        "@PCRE_MINOR@" : "42",
        "@PCRE_PRERELEASE@" : "0",
        "@PCRE_DATE@" : "\"20180520\"",
    },
)

genrule(
    name = "pcre_chartables_c",
    outs = ["pcre_chartables.c"],
    srcs = ["pcre_chartables.c.dist"],
    cmd = "cp $< $@",
)

autoconf_config(
    name = "pcreprivate/config.h",
    src = "config.h.in",
    package = "pcre",
    version = "8.42",
    defines = autoconf_standard_defines + [
        "LINK_SIZE=2",
        "SUPPORT_UCP=1",
        "MATCH_LIMIT=1000000",
        "MATCH_LIMIT_RECURSION=MATCH_LIMIT",
        "SUPPORT_UTF=1",
        "MAX_NAME_COUNT=10000",
        "MAX_NAME_SIZE=32",
        "NEWLINE=10",
        "PARENS_NEST_LIMIT=250",
        "PCRECPP_EXP_DECL=extern __attribute__ ((visibility (\"default\")))",
        "PCRECPP_EXP_DEFN=__attribute__ ((visibility (\"default\")))",
        "PCREGREP_BUFSIZE=20480",
        "PCREPOSIX_EXP_DECL=extern __attribute__ ((visibility (\"default\")))",
        "PCREPOSIX_EXP_DEFN=extern __attribute__ ((visibility (\"default\")))",
        "PCRE_EXP_DATA_DEFN=__attribute__ ((visibility (\"default\")))",
        "PCRE_EXP_DECL=extern __attribute__ ((visibility (\"default\")))",
        "PCRE_EXP_DEFN=__attribute__ ((visibility (\"default\")))",
        "POSIX_MALLOC_THRESHOLD=10",
        "SUPPORT_PCRE8",
    ],
)
