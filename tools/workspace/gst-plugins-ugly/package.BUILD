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
    "-I$(GENDIR)/external/gst-plugins-ugly/gstprivate",
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
    name = "plugins/x264",
    srcs = ["ext/x264/" + x for x in [
        "gstx264enc.c",
        "gstx264enc.h",
    ]] + [
        "gstprivate/config.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS,
    deps = GSTBASE_DEP + GSTVIDEO_DEP + GSTPBUTILS_DEP + [
        "@x264",
    ],
)

cc_library(
    name = "plugins",
    deps = [
        ":plugins/x264",
    ],
)

cc_library(
    name = "gst-plugins-ugly",
    deps = [":plugins"],
)

autoconf_config(
    name = "gstprivate/config.h",
    src = "config.h.in",
    package = "gst-plugins-ugly",
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
        "HOST_CPU=\"x86_64\"",
        "ISO_CODES_PREFIX=\"XXX\"",
        "ISO_CODES_VERSION=\"XXX\"",
        "LOCALEDIR=\"XXX\"",
        "PLUGINDIR=\"XXX\"",
    ],
)
