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
    name = "uuid",
    srcs = ["libuuid/src/" + x for x in [
        "uuidP.h",
        "clear.c",
        "compare.c",
        "copy.c",
        "gen_uuid.c",
        "isnull.c",
        "pack.c",
        "parse.c",
        "unpack.c",
        "unparse.c",
        "uuidd.h",
        "uuid_time.c",
        "predefined.c",
    ]] + [
        "lib/randutils.c",
        "lib/md5.c",
        "lib/sha1.c",
    ] + glob(["include/*.h"]),
    hdrs = [
        "uuid/uuid.h",
    ],
    textual_hdrs = [
        "private/config.h",
    ],
    copts = [
        "-include $(GENDIR)/external/util-linux/private/config.h",
        "-DHAVE_CONFIG_H",
        "-D_PATH_RUNSTATEDIR=\\\"/var/run\\\"",
        "-I$(GENDIR)/external/util-linux/uuid",
        "-Iexternal/util-linux/libuuid/src",
        "-Iexternal/util-linux/include",
    ],
    includes = ["."],
)

cc_library(
    name = "util-linux",
    deps = [":uuid"],
)

genrule(
    name = "move_uuid",
    srcs = ["libuuid/src/uuid.h"],
    outs = ["uuid/uuid.h"],
    cmd = "cp $< $@",
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "util-linux",
    version = "2.32",
    defines = autoconf_standard_defines + [
        "AGETTY_RELOAD",
        "CHFN_CHSH_PASSWORD",
        "CONFIG_ADJTIME_PATH=\"/etc/adjtime\"",
        # "HAVE_LIBMOUNT",
        # "HAVE_LIBNCURSES",
        # "HAVE_LIBUTIL",
        # "HAVE_NCURSES_H",
        "HAVE___FPENDING",
        "HAVE___PROGNAME",
        "LIBBLKID_DATE=\"21-Mar-2018\"",
        "LIBBLKID_VERSION=\"2.32.0\"",
        "LIBFDISK_VERSION=\"2.32.0\"",
        "LIBMOUNT_VERSION=\"2.32.0\"",
        "LIBSMARTCOLS_VERSION=\"2.32.0\"",
        # "MULTIARCHTRIPLET=\"x86_64-linux-gnu\"",
        "ONLY_LISTED_SHELLS",
        "PG_BELL",
        "USE_COLORS_BY_DEFAULT",
        "USE_TTY_GROUP",
    ],
)
