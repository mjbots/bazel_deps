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

SRCS = [
    "common/osdep.c",
    "common/base.c",
    "common/cpu.c",
    "common/tables.c",
    "encoder/api.c",
]

SRCS_X = [
    "common/mc.c",
    "common/predict.c",
    "common/pixel.c",
    "common/macroblock.c",
    "common/frame.c",
    "common/dct.c",
    "common/cabac.c",
    "common/common.c",
    "common/rectangle.c",
    "common/set.c",
    "common/quant.c",
    "common/deblock.c",
    "common/vlc.c",
    "common/mvpred.c",
    "common/bitstream.c",
    "encoder/analyse.c",
    "encoder/me.c",
    "encoder/ratecontrol.c",
    "encoder/set.c",
    "encoder/macroblock.c",
    "encoder/cabac.c",
    "encoder/cavlc.c",
    "encoder/encoder.c",
    "encoder/lookahead.c",

    "common/threadpool.c",
]

TEXTUAL_HDRS = [
    "encoder/rdo.c",
    "encoder/cavlc.c",
    "encoder/cabac.c",
    "encoder/slicetype.c",
]

PRIVATE_HEADERS = [
    "x264private/config.h",
] + glob(["common/**/*.h", "encoder/**/*.h"])

COPTS = [
    "-D_GNU_SOURCE",
    "-I$(GENDIR)/external/x264/x264private",
]

cc_library(
    name = "headers",
    hdrs = [
        "x264.h",
        "x264_config.h",
    ],
    includes = ["."],
)

cc_library(
    name = "x264_8",
    srcs = SRCS_X + PRIVATE_HEADERS,
    textual_hdrs = TEXTUAL_HDRS,
    copts = COPTS + [
        "-DHIGH_BIT_DEPTH=0",
        "-DBIT_DEPTH=8",
    ],
    deps = [":headers"],
)

cc_library(
    name = "x264_10",
    srcs = SRCS_X + PRIVATE_HEADERS,
    textual_hdrs = TEXTUAL_HDRS,
    copts = COPTS + [
        "-DHIGH_BIT_DEPTH=1",
        "-DBIT_DEPTH=10",
    ],
    deps = [":headers"],
)

cc_library(
    name = "x264",
    srcs = SRCS + PRIVATE_HEADERS,
    copts = COPTS,
    deps = [
        ":headers",
        ":x264_8",
        ":x264_10",
    ],
)

genrule(
    name = "x264_config",
    outs = ["x264_config.h"],
    cmd = """cat > $@ <<EOF
#define X264_GPL           1
#define X264_INTERLACED    1
#define X264_BIT_DEPTH     0
#define X264_CHROMA_FORMAT 0
#define X264_VERSION ""
#define X264_POINTVER "0.155.x"
EOF""",
)

genrule(
    name = "config",
    outs = ["x264private/config.h"],
    cmd = """cat > $@ <<EOF
#define HAVE_MALLOC_H 1
#define ARCH_X86_64 0
#define SYS_LINUX 1
#define STACK_ALIGNMENT 64
#define HAVE_POSIXTHREAD 1
#define HAVE_CPU_COUNT 1
#define HAVE_THREAD 1
#define HAVE_LOG2F 1
#define HAVE_STRTOK_R 1
#define HAVE_MMAP 1
#define HAVE_THP 1
#define HAVE_VECTOREXT 0
#define fseek fseeko
#define ftell ftello
#define HAVE_BITDEPTH8 1
#define HAVE_BITDEPTH10 1
#define HAVE_GPL 1
#define HAVE_INTERLACED 1
#define HAVE_OPENCL 0
#define HAVE_ALTIVEC 0
#define HAVE_ALTIVEC_H 0
#define HAVE_MMX 0
#define HAVE_ARMV6 0
#define HAVE_ARMV6T2 0
#define HAVE_NEON 0
#define HAVE_BEOSTHREAD 0
#define HAVE_WIN32THREAD 0
#define HAVE_SWSCALE 0
#define HAVE_LAVF 0
#define HAVE_FFMS 0
#define HAVE_GPAC 0
#define HAVE_AVS 0
#define HAVE_LSMASH 0
#define HAVE_X86_INLINE_ASM 0
#define HAVE_AS_FUNC 0
#define HAVE_INTEL_DISPATCHER 0
#define HAVE_MSA 0
#define HAVE_WINRT 0
#define HAVE_VSX 0
#define HAVE_ARM_INLINE_ASM 0
EOF""",
)
