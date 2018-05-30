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

BASE_SRCS = [
  "src/autofit/autofit.c",
  "src/base/ftbase.c",
  "src/base/ftbbox.c",
  "src/base/ftbdf.c",
  "src/base/ftbitmap.c",
  "src/base/ftcid.c",
  "src/base/ftfstype.c",
  "src/base/ftgasp.c",
  "src/base/ftglyph.c",
  "src/base/ftgxval.c",
  "src/base/ftinit.c",
  "src/base/ftmm.c",
  "src/base/ftotval.c",
  "src/base/ftpatent.c",
  "src/base/ftpfr.c",
  "src/base/ftstroke.c",
  "src/base/ftsynth.c",
  "src/base/ftsystem.c",
  "src/base/fttype1.c",
#  "src/base/ftwinfnt.c",
  "src/bdf/bdf.c",
  "src/bzip2/ftbzip2.c",
  "src/cache/ftcache.c",
  "src/cff/cff.c",
  "src/cid/type1cid.c",
  "src/gzip/ftgzip.c",
  "src/lzw/ftlzw.c",
  "src/pcf/pcf.c",
  "src/pfr/pfr.c",
  "src/psaux/psaux.c",
  "src/pshinter/pshinter.c",
  "src/psnames/psnames.c",
  "src/raster/raster.c",
  "src/sfnt/sfnt.c",
  "src/smooth/smooth.c",
  "src/truetype/truetype.c",
  "src/type1/type1.c",
  "src/type42/type42.c",
  "src/winfonts/winfnt.c",
]

BASE_DICT = dict([(x, None) for x in BASE_SRCS])
HDR_SRCS = dict([(x, None) for x in glob(["src/**/*.c"]) if x not in BASE_DICT]).keys()

cc_library(
    name = "freetype",
    srcs = BASE_SRCS + glob([
        "include/freetype/internal/**/*.h",
        "src/**/*.h",
    ]),
    textual_hdrs = HDR_SRCS,
    hdrs = ["include/ft2build.h"] + glob([
        "include/freetype/*.h",
        "include/freetype/config/*.h",
    ]),
    deps = ["@zlib", "@bzip2"],
    includes = ["include"],
    copts = [
        "-DFT2_BUILD_LIBRARY",
        "-DFT_CONFIG_OPTION_SYSTEM_ZLIB",
        "-DFT_CONFIG_OPTION_USE_BZIP2",
    ],
)
