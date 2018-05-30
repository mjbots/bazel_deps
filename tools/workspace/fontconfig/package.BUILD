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

SOURCES = ["src/" + x for x in [
    "fcarch.h",
    "fcatomic.c",
    "fcatomic.h",
    "fccache.c",
    "fccfg.c",
    "fccharset.c",
    "fccompat.c",
    "fcdbg.c",
    "fcdefault.c",
    "fcdir.c",
    "fcformat.c",
    "fcfreetype.c",
    "fcfs.c",
    "fcptrlist.c",
    "fchash.c",
    "fcinit.c",
    "fclang.c",
    "fclist.c",
    "fcmatch.c",
    "fcmatrix.c",
    "fcmutex.h",
    "fcname.c",
    "fcobjs.c",
    "fcobjs.h",
    "fcobjshash.h",
    "fcpat.c",
    "fcrange.c",
    "fcserialize.c",
    "fcstat.c",
    "fcstr.c",
    "fcweight.c",
    "fcwindows.h",
    "fcxml.c",
    "ftglue.h",
    "ftglue.c",
    "fcint.h",
    "fcstdint.h",
    "fcdeprecate.h",
    "fcftint.h",
    "fcalias.h",
    "fcaliastail.h",
    "fcftalias.h",
    "fcftaliastail.h",
]]

cc_library(
    name = "fontconfig",
    srcs = SOURCES + [
        "fc-case/fccase.h",
        "fc-lang/fclang.h",
        "src/config.h",
        "src/config-fixups.h",
    ],
    hdrs = glob(["fontconfig/*.h"]),
    copts = [
        "-DFC_CACHEDIR=\\\"/var/cache/fontconfig\\\"",
        "-DFONTCONFIG_PATH=\\\"/etc/fonts/\\\"",
        "-DFC_TEMPLATEDIR=\\\"/usr/share/fontconfig/conf.avail\\\"",
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/fontconfig/src",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:clang" : [
            "-Wno-non-literal-null-conversion",
        ],
        "//conditions:default" : [],
    }),
    includes = ["."],
    deps = [
        "@freetype",
        "@util-linux//:uuid",
        "@expat",
    ],
)

sh_binary(
    name = "makealias",
    srcs = ["src/makealias"],
)

genrule(
    name = "fcalias_h",
    outs = ["src/fcalias.h", "src/fcaliastail.h",],
    srcs = glob(["src/*.c"]) + [
        "fontconfig/fontconfig.h",
        "src/fcdeprecate.h",
        "fontconfig/fcprivate.h",
    ],
    cmd = ("SRCDIR=$$(python3 -c \"import os; import sys; print(os.path.commonprefix(sys.argv[1:]))\" $(SRCS)); " +
           "$(location :makealias) $${SRCDIR}/src " +
           "$(location src/fcalias.h) " +
           "$(location src/fcaliastail.h) " +
           "$(location fontconfig/fontconfig.h) " +
           "$(location src/fcdeprecate.h) " +
           "$(location fontconfig/fcprivate.h) "),
    tools = [":makealias"],
)

genrule(
    name = "fcftalias_h",
    outs = ["src/fcftalias.h", "src/fcftaliastail.h",],
    srcs = glob(["src/*.c"]) + [
        "fontconfig/fcfreetype.h",
    ],
    cmd = ("SRCDIR=$$(python3 -c \"import os; import sys; print(os.path.commonprefix(sys.argv[1:]))\" $(SRCS)); " +
           "$(location :makealias) $${SRCDIR}/src " +
           "$(location src/fcftalias.h) " +
           "$(location src/fcftaliastail.h) " +
           "$(location fontconfig/fcfreetype.h) "),
    tools = [":makealias"],
)

genrule(
    name = "config_fixups",
    outs = ["src/config-fixups.h"],
    cmd = "touch $@",
)

autoconf_config(
    name = "src/config.h",
    src = "config.h.in",
    package = "fontconfig",
    version = "2.13.0",
    defines = autoconf_standard_defines + [
        "FC_ADD_FONTS=\"yes\"",
        "FC_DEFAULT_FONTS=\"/usr/share/fonts\"",
        "FC_GPERF_SIZE_T=size_t",
        "FLEXIBLE_ARRAY_MEMBER=/**/",
        "GETTEXT_PACKAGE=\"fontconfig\"",
        "HAVE_FT_DONE_MM_VAR",
        "HAVE_FT_GET_BDF_PROPERTY",
        "HAVE_FT_GET_PS_FONT_INFO",
        "HAVE_FT_GET_X11_FONT_FORMAT",
        "HAVE_FT_HAS_PS_GLYPH_NAMES",
        "HAVE_XML_SETDOCTYPEDECLHANDLER",
        "USE_ICONV=0",
    ],
)
