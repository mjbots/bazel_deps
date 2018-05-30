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

RTSP_SERVER_SOURCES = ["gst/rtsp-server/" + x for x in [
  'rtsp-address-pool.c',
  'rtsp-auth.c',
  'rtsp-client.c',
  'rtsp-context.c',
  'rtsp-media.c',
  'rtsp-media-factory.c',
  'rtsp-media-factory-uri.c',
  'rtsp-mount-points.c',
  'rtsp-params.c',
  'rtsp-permissions.c',
  'rtsp-sdp.c',
  'rtsp-server.c',
  'rtsp-session.c',
  'rtsp-session-media.c',
  'rtsp-session-pool.c',
  'rtsp-stream.c',
  'rtsp-stream-transport.c',
  'rtsp-thread-pool.c',
  'rtsp-token.c',
]]

RTSP_SERVER_HEADERS = ["gst/rtsp-server/" + x for x in [
  'rtsp-auth.h',
  'rtsp-address-pool.h',
  'rtsp-context.h',
  'rtsp-params.h',
  'rtsp-sdp.h',
  'rtsp-thread-pool.h',
  'rtsp-media.h',
  'rtsp-media-factory.h',
  'rtsp-media-factory-uri.h',
  'rtsp-mount-points.h',
  'rtsp-permissions.h',
  'rtsp-stream.h',
  'rtsp-stream-transport.h',
  'rtsp-session.h',
  'rtsp-session-media.h',
  'rtsp-session-pool.h',
  'rtsp-token.h',
  'rtsp-client.h',
  'rtsp-server.h',
  'rtsp-server-prelude.h',
]]

GST_RTSP_SERVER_DEPS = [
    "@gst-plugins-base//:gstrtsp",
    "@gst-plugins-base//:gstrtp",
    "@gst-plugins-base//:gstsdp",
    "@gst-plugins-base//:gstapp",
    "@gstreamer//:libgstnet",
]

GST_RTSP_SERVER_COPTS = [
    "-DHAVE_CONFIG_H",
    "-D_GNU_SOURCE",
    "-I$(GENDIR)/external/gst-rtsp-server/gstprivate",
]

cc_library(
    name = "rtsp-server",
    srcs = RTSP_SERVER_SOURCES,
    hdrs = RTSP_SERVER_HEADERS,
    copts = GST_RTSP_SERVER_COPTS,
    deps = GST_RTSP_SERVER_DEPS,
    includes = ["."],
)

cc_library(
    name = "gst-rtsp-server",
    deps = [":rtsp-server"],
)

autoconf_config(
    name = "gstprivate/config.h",
    src = "config.h.in",
    package = "gst-rtsp-server",
    version = "1.14.1",
    defines = autoconf_standard_defines + [
        "DEFAULT_AUDIOSINK=\"autoaudiosink\"",
        "DEFAULT_AUDIOSRC=\"alsasrc\"",
        "DEFAULT_VIDEOSINK=\"autovideosink\"",
        "DEFAULT_VIDEOSRC=\"vl42src\"",
        "DEFAULT_VISUALIZER=\"goom\"",
        "GIO_LIBDIR=\"XXX\"",
        "GIO_MODULE_DIR=\"XXX\"",
        "GST_LEVEL_DEFAULT=GST_LEVEL_NONE",
        "GST_LICENSE=\"LGPL\"",
        "GST_PACKAGE_NAME=\"XXX\"",
        "GST_PACKAGE_RELEASE_DATETIME=\"2018-05-17\"",
        "PLUGINDIR=\"XXX\"",
    ],
)
