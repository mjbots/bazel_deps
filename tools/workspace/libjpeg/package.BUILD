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

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "libjpeg",
    hdrs = [
        "jconfig.h",
        "jpeglib.h",
        "jmorecfg.h",
        "jerror.h",
    ],
    srcs = [
        "cderror.h",
        "cdjpeg.h",
        "jchuff.h",
        "jdct.h",
        "jdhuff.h",
        "jinclude.h",
        "jmemsys.h",
        "jpegint.h",
        "jversion.h",
        "transupp.h",

        "jmemansi.c",

        "jcomapi.c",
        "jutils.c",
        "jerror.c",
        "jmemmgr.c",
        "jcapimin.c",
        "jcapistd.c",
        "jctrans.c",
        "jcparam.c",
        "jdatadst.c",
        "jcinit.c",
        "jcmaster.c",
        "jcmarker.c",
        "jcmainct.c",
        "jcprepct.c",
        "jccoefct.c",
        "jccolor.c",
        "jcsample.c",
        "jchuff.c",
        "jcphuff.c",
        "jcdctmgr.c",
        "jfdctfst.c",
        "jfdctflt.c",
        "jfdctint.c",
        "jdapimin.c",
        "jdapistd.c",
        "jdtrans.c",
        "jdatasrc.c",
        "jdmaster.c",
        "jdinput.c",
        "jdmarker.c",
        "jdhuff.c",
        "jdphuff.c",
        "jdmainct.c",
        "jdcoefct.c",
        "jdpostct.c",
        "jddctmgr.c",
        "jidctfst.c",
        "jidctflt.c",
        "jidctint.c",
        "jidctred.c",
        "jdsample.c",
        "jdcolor.c",
        "jquant1.c",
        "jquant2.c",
        "jdmerge.c",
    ],
    includes = ["."],
    copts = ["-Wno-main", "-Wno-shift-negative-value"],
)

generate_file(
    name = "jconfig.h",
    content = """
/* jconfig.h.  Generated automatically by configure.  */
/* jconfig.cfg --- source file edited by configure script */
/* see jconfig.doc for explanations */

#define HAVE_PROTOTYPES
#define HAVE_UNSIGNED_CHAR
#define HAVE_UNSIGNED_SHORT
#undef void
#undef const
#undef CHAR_IS_UNSIGNED
#define HAVE_STDDEF_H
#define HAVE_STDLIB_H
#undef NEED_BSD_STRINGS
#undef NEED_SYS_TYPES_H
#undef NEED_FAR_POINTERS
#undef NEED_SHORT_EXTERNAL_NAMES
/* Define this if you get warnings about undefined structures. */
#undef INCOMPLETE_TYPES_BROKEN

#ifdef JPEG_INTERNALS

#undef RIGHT_SHIFT_IS_UNSIGNED
#define INLINE __inline__
/* These are for configuring the JPEG memory manager. */
#undef DEFAULT_MAX_MEM
#undef NO_MKTEMP

#endif /* JPEG_INTERNALS */

#ifdef JPEG_CJPEG_DJPEG

#define BMP_SUPPORTED		/* BMP image file format */
#define GIF_SUPPORTED		/* GIF image file format */
#define PPM_SUPPORTED		/* PBMPLUS PPM/PGM image file format */
#undef RLE_SUPPORTED		/* Utah RLE image file format */
#define TARGA_SUPPORTED		/* Targa image file format */

#undef TWO_FILE_COMMANDLINE
#undef NEED_SIGNAL_CATCHER
#undef DONT_USE_B_MODE

/* Define this if you want percent-done progress reports from cjpeg/djpeg. */
#undef PROGRESS_REPORT

#endif /* JPEG_CJPEG_DJPEG */
    """,
)
