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
    name = "obj",
    hdrs = glob(["**/*.h"]),
    srcs = ["stdlib/" + x for x in [
        "snprintf.c",
        "vsnprintf.c",
        "strlcpy.c",
        "strnlen.c",
    ]] + ["nasmlib/" + x for x in [
        "ver.c",
        "crc64.c",
        "malloc.c",
        "md5c.c",
        "string.c",
        "file.c",
        "mmap.c",
        "ilog2.c",
        "realpath.c",
        "path.c",
        "filename.c",
        "srcfile.c",
        "zerobuf.c",
        "readnum.c",
        "bsi.c",
        "rbtree.c",
        "hashtbl.c",
        "raa.c",
        "saa.c",
        "strlist.c",
        "perfhash.c",
        "badenum.c",
    ]] + [
        "common/common.c",
    ] + ["x86/" + x for x in [
        "insnsa.c",
        "insnsb.c",
        "insnsd.c",
        "insnsn.c",
        "regs.c",
        "regvals.c",
        "regflags.c",
        "regdis.c",
        "disp8.c",
        "iflag.c",
    ]] + ["asm/" + x for x in [
        "error.c",
        "float.c",
        "directiv.c",
        "directbl.c",
        "pragma.c",
        "assemble.c",
        "labels.c",
        "parser.c",
        "preproc.c",
        "quote.c",
        "pptok.c",
        "listing.c",
        "eval.c",
        "exprlib.c",
        "exprdump.c",
        "stdscan.c",
        "strfunc.c",
        "tokhash.c",
        "segalloc.c",
        "preproc-nop.c",
        "rdstrnum.c",
    ]] + [
        "macros/macros.c",
    ] + ["output/" + x for x in [
        "outform.c",
        "outlib.c",
        "legacy.c",
        "nulldbg.c",
        "nullout.c",
        "outbin.c",
        "outaout.c",
        "outcoff.c",
        "outelf.c",
        "outobj.c",
        "outas86.c",
        "outrdf2.c",
        "outdbg.c",
        "outieee.c",
        "outmacho.c",
        "codeview.c",
    ]] + ["disasm/" + x for x in [
        "disasm.c",
        "sync.c",
    ]] + [
        "config/config.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
    ],
    includes = ["include", "x86", "asm", "output"],
)

cc_binary(
    name = "nasm",
    srcs = ["asm/nasm.c"],
    deps = [":obj"],
    copts = ["-DHAVE_CONFIG_H"],
)

autoconf_config(
    name = "config/config.h",
    src = "config/config.h.in",
    package = "nasm",
    version = "2.13.03",
    defines = autoconf_standard_defines + [],
)
