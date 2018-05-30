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
    "-I$(GENDIR)/external/gst-plugins-base/gstprivate",
]

cc_library(
    name = "headers",
    hdrs = [
        "gst-libs/gst/gst-i18n-plugin.h",
        "gst-libs/gst/gettext.h",
    ],
    includes = ["gst-libs"],
)

GST_DEP = [
    "@gstreamer//:gstreamer",
]

GST_BASE_DEP = [
    "@gstreamer//:libgstbase",
    ":headers",
]

VIDEO_DEP = [
    ":gstvideo",
]

X11_DEP = [
    "@libx11",
]

XVIDEO_DEP = [
    "@libxv",
]

######################################
# gst/app

APP_SOURCES = ["gst-libs/gst/app/" + x for x in [
    "gstappsrc.c",
    "gstappsink.c",
]]

cc_library(
    name = "gstapp",
    srcs = APP_SOURCES + [
        "gst-libs/gst/app/app-enumtypes.c",
        "gstprivate/config.h",
    ],
    hdrs = glob(["gst-libs/gst/app/*.h"]) + [
        "gst-libs/gst/app/app-enumtypes.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-Iexternal/gst-plugins-base/gst-libs/gst/app",
    ],
    deps = GST_BASE_DEP,
)

py_binary(
    name = "app_mkenum",
    srcs = ["gst-libs/gst/app/app_mkenum.py"],
)

APP_MKENUM_HEADERS = ["gst-libs/gst/app/gstappsrc.h"]

genrule(
    name = "gstapp_h",
    srcs = APP_MKENUM_HEADERS,
    outs = ["gst-libs/gst/app/app-enumtypes.h"],
    tools = [":app_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :app_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstapp_c",
    srcs = APP_MKENUM_HEADERS,
    outs = ["gst-libs/gst/app/app-enumtypes.c"],
    tools = [":app_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :app_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

######################################
# gst/tag
TAG_SOURCES = ["gst-libs/gst/tag/" + x for x in [
  'gstvorbistag.c',
  'gstid3tag.c',
  'gstxmptag.c',
  'gstexiftag.c',
  'lang.c',
  'licenses.c',
  'tags.c',
  'gsttagdemux.c',
  'gsttagmux.c',
  'gsttageditingprivate.c',
  'id3v2.c',
  'id3v2frames.c',
  'xmpwriter.c',
  'gsttageditingprivate.h',
]]

TAG_MKENUM_HEADERS = ["gst-libs/gst/tag/" + x for x in [
  'gsttagdemux.h',
  'tag.h',
]]

TAG_HEADERS = TAG_MKENUM_HEADERS + ["gst-libs/gst/tag/" + x for x in [
  'gsttagmux.h',
  'xmpwriter.h',
  'tag-prelude.h',
  'id3v2.h',
]]

py_binary(
    name = "tag_mkenum",
    srcs = ["gst-libs/gst/tag/tag_mkenum.py"],
)

genrule(
    name = "gsttag_h",
    srcs = TAG_MKENUM_HEADERS,
    outs = ["gst-libs/gst/tag/tag-enumtypes.h"],
    tools = [":tag_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :tag_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gsttag_c",
    srcs = TAG_MKENUM_HEADERS,
    outs = ["gst-libs/gst/tag/tag-enumtypes.c"],
    tools = [":tag_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :tag_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gsttag",
    srcs = TAG_SOURCES + [
        "gst-libs/gst/tag/tag-enumtypes.c",
        "gstprivate/config.h",
    ],
    hdrs = TAG_HEADERS + [
        "gst-libs/gst/tag/tag-enumtypes.h",
    ],
    textual_hdrs = [
        "gst-libs/gst/tag/lang-tables.dat",
        "gst-libs/gst/tag/licenses-tables.dat",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst-libs/gst/tag",
        "-Iexternal/gst-plugins-base/gst-libs/gst/tag",
    ],
    deps = GST_BASE_DEP + [
        "@zlib",
    ],
)


######################################
# gst/video
VIDEO_SOURCES = ["gst-libs/gst/video/" + x for x in [
  'colorbalance.c',
  'colorbalancechannel.c',
  'convertframe.c',
  'gstvideoaffinetransformationmeta.c',
  'gstvideodecoder.c',
  'gstvideoencoder.c',
  'gstvideofilter.c',
  'gstvideometa.c',
  'gstvideopool.c',
  'gstvideosink.c',
  'gstvideotimecode.c',
  'gstvideoutils.c',
  'gstvideoutilsprivate.c',
  'gstvideoutilsprivate.h',
  'navigation.c',
  'video.c',
  'video-blend.c',
  'video-chroma.c',
  'video-color.c',
  'video-converter.c',
  'video-dither.c',
  'video-event.c',
  'video-format.c',
  'video-frame.c',
  'video-info.c',
  'video-multiview.c',
  'video-resampler.c',
  'video-scaler.c',
  'video-tile.c',
  'video-overlay-composition.c',
  'videodirection.c',
  'videoorientation.c',
  'videooverlay.c',
  'video-orc.c',
]]

VIDEO_HEADERS = ["gst-libs/gst/video/" + x for x in [
  'colorbalance.h',
  'colorbalancechannel.h',
  'gstvideoaffinetransformationmeta.h',
  'gstvideodecoder.h',
  'gstvideoencoder.h',
  'gstvideofilter.h',
  'gstvideometa.h',
  'gstvideopool.h',
  'gstvideosink.h',
  'gstvideotimecode.h',
  'gstvideoutils.h',
  'navigation.h',
  'video.h',
  'video-event.h',
  'video-format.h',
  'video-chroma.h',
  'video-color.h',
  'video-converter.h',
  'video-dither.h',
  'video-info.h',
  'video-frame.h',
  'video-prelude.h',
  'video-scaler.h',
  'video-tile.h',
  'videodirection.h',
  'videoorientation.h',
  'videooverlay.h',
  'video-resampler.h',
  'video-blend.h',
  'video-overlay-composition.h',
  'video-multiview.h',
  'video-orc.h',
]]

VIDEO_MKENUM_HEADERS = ["gst-libs/gst/video/" + x for x in [
  'video.h',
  'video-format.h',
  'video-frame.h',
  'video-chroma.h',
  'video-color.h',
  'video-converter.h',
  'video-dither.h',
  'video-info.h',
  'video-resampler.h',
  'video-scaler.h',
  'video-tile.h',
  'colorbalance.h',
  'navigation.h',
]]

py_binary(
    name = "video_mkenum",
    srcs = ["gst-libs/gst/video/video_mkenum.py"],
)

genrule(
    name = "videoorc_h",
    outs = ["gst-libs/gst/video/video-orc.h"],
    srcs = ["gst-libs/gst/video/video-orc-dist.h"],
    cmd = "cp $< $@",
)

genrule(
    name = "videoorc_c",
    outs = ["gst-libs/gst/video/video-orc.c"],
    srcs = ["gst-libs/gst/video/video-orc-dist.c"],
    cmd = "cp $< $@",
)

genrule(
    name = "gstvideo_h",
    srcs = VIDEO_MKENUM_HEADERS,
    outs = ["gst-libs/gst/video/video-enumtypes.h"],
    tools = [":video_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :video_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstvideo_c",
    srcs = VIDEO_MKENUM_HEADERS,
    outs = ["gst-libs/gst/video/video-enumtypes.c"],
    tools = [":video_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :video_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gstvideo_headers",
    hdrs = VIDEO_HEADERS + [
        "gst-libs/gst/video/video-enumtypes.h",
    ],
    deps = GST_BASE_DEP,
)

cc_library(
    name = "gstvideo",
    srcs = VIDEO_SOURCES + [
        "gst-libs/gst/video/video-enumtypes.c",
        "gstprivate/config.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst-libs/gst/video",
        "-Iexternal/gst-plugins-base/gst-libs/gst/video",
    ],
    deps = [":gstvideo_headers"],
)


######################################
# gst/pbutils
PBUTILS_SOURCES = ["gst-libs/gst/pbutils/" + x for x in [
  'gstpluginsbaseversion.c',
  'pbutils.c',
  'codec-utils.c',
  'descriptions.c',
  'encoding-profile.c',
  'encoding-target.c',
  'install-plugins.c',
  'missing-plugins.c',
  'gstaudiovisualizer.c',
  'gstdiscoverer.c',
  'gstdiscoverer-types.c',
  'pbutils-private.h',
]]

PBUTILS_HEADERS = ["gst-libs/gst/pbutils/" + x for x in [
  'gstpluginsbaseversion.h',
  'pbutils.h',
  'pbutils-prelude.h',
  'codec-utils.h',
  'descriptions.h',
  'encoding-profile.h',
  'encoding-target.h',
  'install-plugins.h',
  'missing-plugins.h',
  'gstdiscoverer.h',
  'gstaudiovisualizer.h',
]]

template_file(
    name = "gst-libs/gst/pbutils/gstpluginsbaseversion.h",
    src = "gst-libs/gst/pbutils/gstpluginsbaseversion.h.in",
    substitutions = {
        "@PACKAGE_VERSION_MAJOR@" : "1",
        "@PACKAGE_VERSION_MINOR@" : "14",
        "@PACKAGE_VERSION_MICRO@" : "1",
        "@PACKAGE_VERSION_NANO@" : "0",
    }
)

py_binary(
    name = "pbutils_mkenum",
    srcs = ["gst-libs/gst/pbutils/pbutils_mkenum.py"],
)

genrule(
    name = "gstpbutils_h",
    srcs = PBUTILS_HEADERS,
    outs = ["gst-libs/gst/pbutils/pbutils-enumtypes.h"],
    tools = [":pbutils_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :pbutils_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstpbutils_c",
    srcs = PBUTILS_HEADERS,
    outs = ["gst-libs/gst/pbutils/pbutils-enumtypes.c"],
    tools = [":pbutils_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :pbutils_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gstpbutils",
    srcs = PBUTILS_SOURCES + [
        "gst-libs/gst/pbutils/pbutils-enumtypes.c",
        "gstprivate/config.h",
    ],
    hdrs = PBUTILS_HEADERS + [
        "gst-libs/gst/pbutils/pbutils-enumtypes.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst-libs/gst/pbutils",
        "-Iexternal/gst-plugins-base/gst-libs/gst/pbutils",
    ],
    deps = GST_BASE_DEP + [
        ":gstvideo_headers",
        ":gstaudio_headers",
        ":gsttag",
    ],
)

######################################
# gst/audio
AUDIO_SOURCES = ["gst-libs/gst/audio/" + x for x in [
  'audio.c',
  'audio-channel-mixer.c',
  'audio-channels.c',
  'audio-converter.c',
  'audio-format.c',
  'audio-info.c',
  'audio-quantize.c',
  'audio-resampler.c',
  'gstaudioaggregator.c',
  'gstaudiobasesink.c',
  'gstaudiobasesrc.c',
  'gstaudiocdsrc.c',
  'gstaudioclock.c',
  'gstaudiodecoder.c',
  'gstaudioencoder.c',
  'gstaudiofilter.c',
  'gstaudioiec61937.c',
  'gstaudiometa.c',
  'gstaudioringbuffer.c',
  'gstaudiosink.c',
  'gstaudiosrc.c',
  'gstaudioutilsprivate.c',
  'gstaudioutilsprivate.h',
  'streamvolume.c',
  'gstaudiostreamalign.c',
    'audio-resampler-private.h',
    'audio-resampler-macros.h',
    'gstaudiopack.c',
]]

AUDIO_MKENUM_HEADERS = ["gst-libs/gst/audio/" + x for x in [
  'audio.h',
  'audio-format.h',
  'audio-channels.h',
  'audio-channel-mixer.h',
  'audio-converter.h',
  'audio-info.h',
  'audio-quantize.h',
  'audio-resampler.h',
  'gstaudioaggregator.h',
  'gstaudioringbuffer.h',
  'gstaudiobasesrc.h',
  'gstaudiocdsrc.h',
  'gstaudiobasesink.h',
  'gstaudiostreamalign.h',
]]

genrule(
    name = "audioorc_h",
    outs = ["gst-libs/gst/audio/gstaudiopack.h"],
    srcs = ["gst-libs/gst/audio/gstaudiopack-dist.h"],
    cmd = "cp $< $@",
)

genrule(
    name = "audioorc_c",
    outs = ["gst-libs/gst/audio/gstaudiopack.c"],
    srcs = ["gst-libs/gst/audio/gstaudiopack-dist.c"],
    cmd = "cp $< $@",
)

AUDIO_HEADERS = AUDIO_MKENUM_HEADERS + ["gst-libs/gst/audio/" + x for x in [
  'audio-prelude.h',
  'gstaudioclock.h',
  'gstaudiodecoder.h',
  'gstaudioencoder.h',
  'gstaudiofilter.h',
  'gstaudioiec61937.h',
  'gstaudiometa.h',
  'gstaudiosink.h',
  'gstaudiosrc.h',
  'streamvolume.h',
    'gstaudiopack.h',
]]

py_binary(
    name = "audio_mkenum",
    srcs = ["gst-libs/gst/audio/audio_mkenum.py"],
)

genrule(
    name = "gstaudio_h",
    srcs = AUDIO_MKENUM_HEADERS,
    outs = ["gst-libs/gst/audio/audio-enumtypes.h"],
    tools = [":audio_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :audio_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstaudio_c",
    srcs = AUDIO_MKENUM_HEADERS,
    outs = ["gst-libs/gst/audio/audio-enumtypes.c"],
    tools = [":audio_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :audio_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gstaudio_headers",
    hdrs = AUDIO_HEADERS + [
        "gst-libs/gst/audio/audio-enumtypes.h",
    ],
    deps = GST_BASE_DEP,
)

cc_library(
    name = "gstaudio",
    srcs = AUDIO_SOURCES + [
        "gst-libs/gst/audio/audio-enumtypes.c",
        "gstprivate/config.h",
    ],
    textual_hdrs = [
        "gst-libs/gst/audio/dbesi0.c",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst-libs/gst/audio",
        "-Iexternal/gst-plugins-base/gst-libs/gst/audio",
    ],
    deps = [
        ":gstaudio_headers",
        ":gstpbutils",
    ],
)

######################################
# gst/rtp
RTP_SOURCES = ["gst-libs/gst/rtp/" + x for x in [
  'gstrtpbuffer.c',
  'gstrtcpbuffer.c',
  'gstrtppayloads.c',
  'gstrtphdrext.c',
  'gstrtpbaseaudiopayload.c',
  'gstrtpbasepayload.c',
  'gstrtpbasedepayload.c'
]]

RTP_HEADERS = ["gst-libs/gst/rtp/" + x for x in [
  'gstrtcpbuffer.h',
  'gstrtpbaseaudiopayload.h',
  'gstrtpbasedepayload.h',
  'gstrtpbasepayload.h',
  'gstrtpbuffer.h',
  'gstrtpdefs.h',
  'gstrtphdrext.h',
  'gstrtppayloads.h',
  'rtp-prelude.h',
  'rtp.h',
]]

py_binary(
    name = "rtp_mkenum",
    srcs = ["gst-libs/gst/rtp/rtp_mkenum.py"],
)

genrule(
    name = "gstrtp_h",
    srcs = RTP_HEADERS,
    outs = ["gst-libs/gst/rtp/gstrtp-enumtypes.h"],
    tools = [":rtp_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :rtp_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstrtp_c",
    srcs = RTP_HEADERS,
    outs = ["gst-libs/gst/rtp/gstrtp-enumtypes.c"],
    tools = [":rtp_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :rtp_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gstrtp",
    srcs = RTP_SOURCES + [
        "gst-libs/gst/rtp/gstrtp-enumtypes.c",
        "gstprivate/config.h",
    ],
    hdrs = RTP_HEADERS + [
        "gst-libs/gst/rtp/gstrtp-enumtypes.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-Iexternal/gst-plugins-base/gst-libs/gst/rtp",
    ],
    deps = GST_BASE_DEP + [
        ":gstaudio",
    ],
)


######################################
# gst/sdp
GST_SDP_HEADERS = ["gst-libs/gst/sdp/" + x for x in [
  'sdp.h',
  'sdp-prelude.h',
  'gstsdp.h',
  'gstmikey.h',
  'gstsdpmessage.h',
]]

GST_SDP_SOURCES = ["gst-libs/gst/sdp/" + x for x in [
    'gstsdpmessage.c',
    'gstmikey.c'
]]

cc_library(
    name = "gstsdp",
    srcs = GST_SDP_SOURCES + [
        "gstprivate/config.h",
    ],
    hdrs = GST_SDP_HEADERS,
    copts = GST_PLUGINS_BASE_COPTS,
    deps = GST_BASE_DEP + [
        ":gstrtp",
    ],
)

######################################
# gst/rtsp

RTSP_SOURCES = ["gst-libs/gst/rtsp/" + x for x in [
  'gstrtsptransport.c',
  'gstrtspurl.c',
  'gstrtspmessage.c',
  'gstrtspconnection.c',
  'gstrtspdefs.c',
  'gstrtspextension.c',
  'gstrtsprange.c'
]]

RTSP_HEADERS = ["gst-libs/gst/rtsp/" + x for x in [
  'gstrtspconnection.h',
  'gstrtspdefs.h',
  'gstrtspextension.h',
  'gstrtsp.h',
  'gstrtspmessage.h',
  'gstrtsprange.h',
  'gstrtsptransport.h',
  'gstrtspurl.h',
  'rtsp-prelude.h',
  'rtsp.h',
]]

py_binary(
    name = "rtsp_mkenum",
    srcs = ["gst-libs/gst/rtsp/rtsp_mkenum.py"],
)

genrule(
    name = "gstrtsp_h",
    srcs = RTSP_HEADERS,
    outs = ["gst-libs/gst/rtsp/gstrtsp-enumtypes.h"],
    tools = [":rtsp_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :rtsp_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

genrule(
    name = "gstrtsp_c",
    srcs = RTSP_HEADERS,
    outs = ["gst-libs/gst/rtsp/gstrtsp-enumtypes.c"],
    tools = [":rtsp_mkenum", "@glib//:glib-mkenums"],
    cmd = (
        "$(location :rtsp_mkenum) " +
        "$(location @glib//:glib-mkenums) " +
        "$@ $(SRCS)"),
)

cc_library(
    name = "gstrtsp",
    srcs = RTSP_SOURCES + [
        "gst-libs/gst/rtsp/gstrtsp-enumtypes.c",
        "gstprivate/config.h",
    ],
    hdrs = RTSP_HEADERS + [
        "gst-libs/gst/rtsp/gstrtsp-enumtypes.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst-libs/gst/rtsp",
        "-Iexternal/gst-plugins-base/gst-libs/gst/rtsp",
    ],
    deps = GST_BASE_DEP + [
        ":gstsdp",
    ],
)


######################################
# gst/app

cc_library(
    name = "plugins/gstapp",
    srcs = [
        "gst/app/gstapp.c",
        "gstprivate/config.h",
    ],
    copts = GST_PLUGINS_BASE_COPTS,
    deps = GST_DEP + GST_BASE_DEP + [
        ":gstapp",
    ],
)


######################################
# gst/videotestsrc

genrule(
    name = "gstvideotestsrcorc_h",
    outs = ["gst/videotestsrc/gstvideotestsrcorc.h"],
    srcs = ["gst/videotestsrc/gstvideotestsrcorc-dist.h"],
    cmd = "cp $< $@",
)

genrule(
    name = "gstvideotestsrcorc_c",
    outs = ["gst/videotestsrc/gstvideotestsrcorc.c"],
    srcs = ["gst/videotestsrc/gstvideotestsrcorc-dist.c"],
    cmd = "cp $< $@",
)

cc_library(
    name = "plugins/videotestsrc",
    srcs = ["gst/videotestsrc/" + x for x in [
        "gstvideotestsrc.c",
        "gstvideotestsrc.h",
        "videotestsrc.c",
        "videotestsrc.h",
        "gstvideotestsrcorc.h",
        "gstvideotestsrcorc.c",
    ]],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-I$(GENDIR)/external/gst-plugins-base/gst/videotestsrc",
        "-Iexternal/gst-plugins-base/gst/videotestsrc",
    ],
    deps = VIDEO_DEP + GST_DEP + GST_BASE_DEP,
)

######################################
# gst/videoconvert

cc_library(
    name = "plugins/videoconvert",
    srcs = ["gst/videoconvert/" + x for x in [
        "gstvideoconvert.c",
        "gstvideoconvert.h",
    ]],
    copts = GST_PLUGINS_BASE_COPTS,
    deps = VIDEO_DEP + GST_DEP + GST_BASE_DEP,
)

######################################
# gst/videoconvert

cc_library(
    name = "plugins/gstpango",
    srcs = ["ext/pango/" + x for x in [
        'gstbasetextoverlay.c',
        'gstclockoverlay.c',
        'gsttextoverlay.c',
        'gsttextrender.c',
        'gsttimeoverlay.c',
        'gstbasetextoverlay.h',
        'gstclockoverlay.h',
        'gsttextoverlay.h',
        'gsttextrender.h',
        'gsttimeoverlay.h',
    ]],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-Iexternal/gst-plugins-base/ext/pango",
    ],
    deps = ["@pango"] + VIDEO_DEP + GST_DEP + GST_BASE_DEP,
)

######################################
# sys/xvimage

cc_library(
    name = "plugins/xvimage",
    srcs = ["sys/xvimage/" + x for x in [
        'xvcontext.c',
        'xvcontext.h',
        'xvimageallocator.c',
        'xvimageallocator.h',
        'xvimage.c',
        'xvimagepool.c',
        'xvimagepool.h',
        'xvimagesink.c',
        'xvimagesink.h',
    ]],
    copts = GST_PLUGINS_BASE_COPTS + [
        "-Iexternal/gst-plugins-base/sys/xvimage",
        "-DCAT_PERFORMANCE=CAT_PERFORMANCE2",
    ],
    deps = XVIDEO_DEP + X11_DEP + VIDEO_DEP + GST_DEP + GST_BASE_DEP,
)


######################################
# all plugins

cc_library(
    name = "plugins",
    deps = [
        ":plugins/gstapp",
        ":plugins/videotestsrc",
        ":plugins/videoconvert",
        ":plugins/gstpango",
        ":plugins/xvimage",
    ],
)

cc_library(
    name = "gst-plugins-base",
    deps = [":plugins"],
)

####################################
# General config

autoconf_config(
    name = "gstprivate/config.h",
    src = "config.h.in",
    package = "gst-plugins-base",
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
