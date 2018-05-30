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
    name = "libffi",
    hdrs = [
        "ffiprivate/fficonfig.h",
        "include/ffi.h",
        "include/ffi_cfi.h",
        "include/ffitarget.h",
    ],
    srcs = select({
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "src/x86/ffi64.c",
            "src/x86/ffiw64.c",
            "src/x86/win64.S",
            "src/x86/unix64.S",
            "src/x86/ffi.c",
            "src/x86/sysv.S",
            "src/x86/internal64.h",
            "src/x86/asmnames.h",
        ],
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
            "src/arm/sysv.S",
            "src/arm/ffi.c",
            "src/arm/internal.h",
        ],
    }) + ["src/" + x for x in [
        "prep_cif.c",
        "types.c",
        "raw_api.c",
        "java_raw_api.c",
        "closures.c",
    ]] + [
        "include/ffi_common.h",
    ],
    textual_hdrs = [
        "src/dlmalloc.c",
    ],
    includes = ["include"],
    copts = [
        "-I$(GENDIR)/external/libffi/ffiprivate",
    ],
)

genrule(
    name = "ffitarget",
    srcs = select({
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "src/x86/ffitarget.h",
        ],
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
            "src/arm/ffitarget.h",
        ],
    }),
    outs = [
        "include/ffitarget.h",
    ],
    cmd = "cp $< $@",
)

autoconf_config(
    name = "ffiprivate/fficonfig.h",
    src = "fficonfig.h.in",
    defines = autoconf_standard_defines + select({
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "HAVE_AS_X86_64_UNWIND_SECTION_TYPE",
            "HAVE_AS_X86_PCREL",
        ],
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
        ],
    }) + [
        "EH_FRAME_FLAGS=\"a\"",
        "HAVE_AS_ASCII_PSEUDO_OP",
        "HAVE_AS_CFI_PSEUDO_OP",
        "HAVE_AS_STRING_PSEUDO_OP",
        "HAVE_RO_EH_FRAME",
    ],
)

template_file(
    name = "include/ffi.h",
    src = "include/ffi.h.in",
    substitution_list = select({
        "@com_github_mjbots_bazel_deps//conditions:x86_64" : [
            "@TARGET@=X86_64",
        ],
        "@com_github_mjbots_bazel_deps//conditions:arm" : [
            "@TARGET@=ARM",
        ],
    }) +  [
        "@VERSION@=XXX",
        "@HAVE_LONG_DOUBLE@=1",
        "@HAVE_LONG_DOUBLE_VARIANT@=0",
        "@FFI_EXEC_TRAMPOLINE_TABLE@=0",
    ],
)
