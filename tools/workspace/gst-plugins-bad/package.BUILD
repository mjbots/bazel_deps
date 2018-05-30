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

GST_PLUGINS_BASE_COPTS = [
    "-DHAVE_CONFIG_H",
    "-D_GNU_SOURCE",
    "-I$(GENDIR)/external/gst-plugins-bad/gstprivate",
]

GSTBASE_DEP = [
    "@gstreamer//:libgstbase",
]

GSTVIDEO_DEP = [
    "@gst-plugins-base//:gstvideo",
]

GSTPBUTILS_DEP = [
    "@gst-plugins-base//:gstpbutils",
]

cc_library(
    name = "gst_headers",
    includes = ["gst-libs"],
)

#############################################
# gst-libs/codecparsers

CODECPARSER_SOURCES = ["gst-libs/gst/codecparsers/" + x for x in [
  'gstjpeg2000sampling.c',
  'gstjpegparser.c',
  'gstmpegvideoparser.c',
  'gsth264parser.c',
  'gstvc1parser.c',
  'gstmpeg4parser.c',
  'gsth265parser.c',
  'gstvp8parser.c',
  'gstvp8rangedecoder.c',
  'gstvp9parser.c',
  'vp9utils.c',
  'parserutils.c',
  'nalutils.c',
  'dboolhuff.c',
  'vp8utils.c',
  'gstmpegvideometa.c',
]]

CODECPARSER_HEADERS = ["gst-libs/gst/codecparsers/" + x for x in [
  'codecparsers-prelude.h',
  'gstmpegvideoparser.h',
  'gsth264parser.h',
  'gstvc1parser.h',
  'gstmpeg4parser.h',
  'gsth265parser.h',
  'gstvp8parser.h',
  'gstvp8rangedecoder.h',
  'gstjpeg2000sampling.h',
  'gstjpegparser.h',
  'gstmpegvideometa.h',
  'gstvp9parser.h',
    'nalutils.h',
    'vp8utils.h',
    'vp9utils.h',
    'dboolhuff.h',
    'parserutils.h',
]]

cc_library(
    name = "gstcodecparsers",
    srcs = CODECPARSER_SOURCES + [
        "gstprivate/config.h",
    ],
    hdrs = CODECPARSER_HEADERS,
    copts = GST_PLUGINS_BASE_COPTS + [
        '-DGST_USE_UNSTABLE_API',
        '-Dvp8_norm=gst_codecparsers_vp8_norm',
        '-Dvp8dx_start_decode=gst_codecparsers_vp8dx_start_decode',
        '-Dvp8dx_bool_decoder_fill=gst_codecparsers_vp8dx_bool_decoder_fill',
        "-Wno-cpp",
    ],
    deps = GSTBASE_DEP + [":gst_headers"],
)


#############################################
# gst/videoparsers

cc_library(
    name = "plugins/videoparsers",
    srcs = ["gst/videoparsers/" + x for x in [
        'plugin.c',
        'h263parse.c',
        'gsth263parse.c',
        'gstdiracparse.c',
        'dirac_parse.c',
        'gsth264parse.c',
        'gstmpegvideoparse.c',
        'gstmpeg4videoparse.c',
        'gstpngparse.c',
        'gstvc1parse.c',
        'gsth265parse.c',
        'gstjpeg2000parse.c',
    ]] + [
        "gstprivate/config.h",
    ],
    hdrs = glob(["gst/videoparsers/*.h"]),
    copts = GST_PLUGINS_BASE_COPTS + [
        "-Wno-cpp",
    ],
    deps = GSTBASE_DEP + GSTVIDEO_DEP + GSTPBUTILS_DEP + [
        "//:gstcodecparsers",
    ],
)

cc_library(
    name = "plugins",
    deps = [
        ":plugins/videoparsers",
    ],
)

cc_library(
    name = "gst-plugins-bad",
    deps = [":plugins"],
)

autoconf_config(
    name = "gstprivate/config.h",
    src = "config.h.in",
    package = "gst-plugins-bad",
    version = "1.14.1",
    defines = autoconf_standard_defines + [
        "DEFAULT_AUDIOSINK=\"autoaudiosink\"",
        "DEFAULT_AUDIOSRC=\"alsasrc\"",
        "DEFAULT_VIDEOSINK=\"autovideosink\"",
        "DEFAULT_VIDEOSRC=\"vl42src\"",
        "DEFAULT_VISUALIZER=\"goom\"",
        "DISABLE_ORC",
        "GETTEXT_PACKAGE=\"XXX\"",
        "GIO_LIBDIR=\"XXX\"",
        "GIO_MODULE_DIR=\"XXX\"",
        "GIO_PREFIX=\"XXX\"",
        "GST_API_VERSION=\"1.0\"",
        "GST_DATADIR=\"XXX\"",
        "GST_FUNCTION=__PRETTY_FUNCTION__",
        "GST_INSTALL_PLUGINS_HELPER=\"XXX\"",
        "GST_LEVEL_DEFAULT=GST_LEVEL_NONE",
        "GST_LICENSE=\"LGPL\"",
        "GST_PACKAGE_NAME=\"XXX\"",
        "GST_PACKAGE_ORIGIN=\"XXX\"",
        "GST_PACKAGE_RELEASE_DATETIME=\"2018-05-17\"",

        "ISO_CODES_PREFIX=\"XXX\"",
        "ISO_CODES_VERSION=\"XXX\"",
        "LOCALEDIR=\"XXX\"",
        "PLUGINDIR=\"XXX\"",
    ],
)
