# -*- python -*-

# Copyright 2018-2019 Josh Pieper, jjp@pobox.com.
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

load("//tools/workspace/boost:repository.bzl", "boost_repository")
load("//tools/workspace/bzip2:repository.bzl", "bzip2_repository")
load("//tools/workspace/cairo:repository.bzl", "cairo_repository")
load("//tools/workspace/eigen:repository.bzl", "eigen_repository")
load("//tools/workspace/expat:repository.bzl", "expat_repository")
load("//tools/workspace/ffmpeg:repository.bzl", "ffmpeg_repository")
load("//tools/workspace/fmt:repository.bzl", "fmt_repository")
load("//tools/workspace/fontconfig:repository.bzl", "fontconfig_repository")
load("//tools/workspace/freetype:repository.bzl", "freetype_repository")
load("//tools/workspace/fribidi:repository.bzl", "fribidi_repository")
load("//tools/workspace/glib:repository.bzl", "glib_repository")
load("//tools/workspace/gstreamer:repository.bzl", "gstreamer_repository")
load("//tools/workspace/gst-libav:repository.bzl", "gst_libav_repository")
load("//tools/workspace/gst-plugins-bad:repository.bzl", "gst_plugins_bad_repository")
load("//tools/workspace/gst-plugins-base:repository.bzl", "gst_plugins_base_repository")
load("//tools/workspace/gst-plugins-good:repository.bzl", "gst_plugins_good_repository")
load("//tools/workspace/gst-plugins-ugly:repository.bzl", "gst_plugins_ugly_repository")
load("//tools/workspace/gst-rtsp-server:repository.bzl", "gst_rtsp_server_repository")
load("//tools/workspace/harfbuzz:repository.bzl", "harfbuzz_repository")
load("//tools/workspace/libffi:repository.bzl", "libffi_repository")
load("//tools/workspace/libjpeg:repository.bzl", "libjpeg_repository")
load("//tools/workspace/libpng:repository.bzl", "libpng_repository")
load("//tools/workspace/libx11:repository.bzl", "libx11_repository")
load("//tools/workspace/libxau:repository.bzl", "libxau_repository")
load("//tools/workspace/libxcb:repository.bzl", "libxcb_repository")
load("//tools/workspace/libxdmcp:repository.bzl", "libxdmcp_repository")
load("//tools/workspace/libxext:repository.bzl", "libxext_repository")
load("//tools/workspace/libxv:repository.bzl", "libxv_repository")
load("//tools/workspace/log4cpp:repository.bzl", "log4cpp_repository")
load("//tools/workspace/nasm:repository.bzl", "nasm_repository")
load("//tools/workspace/opencv:repository.bzl", "opencv_repository")
load("//tools/workspace/pango:repository.bzl", "pango_repository")
load("//tools/workspace/pcre:repository.bzl", "pcre_repository")
load("//tools/workspace/pixman:repository.bzl", "pixman_repository")
load("//tools/workspace/python:repository.bzl", "python_repository")
load("//tools/workspace/snappy:repository.bzl", "snappy_repository")
load("//tools/workspace/spdlog:repository.bzl", "spdlog_repository")
load("//tools/workspace/util-linux:repository.bzl", "util_linux_repository")
load("//tools/workspace/videoproto:repository.bzl", "videoproto_repository")
load("//tools/workspace/x264:repository.bzl", "x264_repository")
load("//tools/workspace/xcb-proto:repository.bzl", "xcb_proto_repository")
load("//tools/workspace/xorgproto:repository.bzl", "xorgproto_repository")
load("//tools/workspace/xtrans:repository.bzl", "xtrans_repository")
load("//tools/workspace/zlib:repository.bzl", "zlib_repository")

def get_default_config():
    return {
        "opts" : ["sse", "sse2"],
    }

def add_default_repositories(excludes = [], config = get_default_config()):
    if "boost" not in excludes:
        boost_repository(name = "boost")
    if "bzip2" not in excludes:
        bzip2_repository(name = "bzip2")
    if "cairo" not in excludes:
        cairo_repository(name = "cairo")
    if "eigen" not in excludes:
        eigen_repository(name = "eigen")
    if "expat" not in excludes:
        expat_repository(name = "expat")
    if "ffmpeg" not in excludes:
        ffmpeg_repository(name = "ffmpeg")
    if "fmt" not in excludes:
        fmt_repository(name = "fmt")
    if "fontconfig" not in excludes:
        fontconfig_repository(name = "fontconfig")
    if "freetype" not in excludes:
        freetype_repository(name = "freetype")
    if "fribidi" not in excludes:
        fribidi_repository(name = "fribidi")
    if "glib" not in excludes:
        glib_repository(name = "glib")
    if "gstreamer" not in excludes:
        gstreamer_repository(name = "gstreamer")
    if "gst-libav" not in excludes:
        gst_libav_repository(name = "gst-libav")
    if "gst-plugins-bad" not in excludes:
        gst_plugins_bad_repository(name = "gst-plugins-bad")
    if "gst-plugins-base" not in excludes:
        gst_plugins_base_repository(name = "gst-plugins-base")
    if "gst-plugins-good" not in excludes:
        gst_plugins_good_repository(name = "gst-plugins-good")
    if "gst-plugins-ugly" not in excludes:
        gst_plugins_ugly_repository(name = "gst-plugins-ugly")
    if "gst-rtsp-server" not in excludes:
        gst_rtsp_server_repository(name = "gst-rtsp-server")
    if "harfbuzz" not in excludes:
        harfbuzz_repository(name = "harfbuzz")
    if "libffi" not in excludes:
        libffi_repository(name = "libffi")
    if "libjpeg" not in excludes:
        libjpeg_repository(name = "libjpeg")
    if "libpng" not in excludes:
        libpng_repository(name = "libpng")
    if "libx11" not in excludes:
        libx11_repository(name = "libx11")
    if "libxau" not in excludes:
        libxau_repository(name = "libxau")
    if "libxcb" not in excludes:
        libxcb_repository(name = "libxcb")
    if "libxdmcp" not in excludes:
        libxdmcp_repository(name = "libxdmcp")
    if "libxext" not in excludes:
        libxext_repository(name = "libxext")
    if "libxv" not in excludes:
        libxv_repository(name = "libxv")
    if "log4cpp" not in excludes:
        log4cpp_repository(name = "log4cpp")
    if "nasm" not in excludes:
        nasm_repository(name = "nasm")
    if "opencv" not in excludes:
        opencv_repository(name = "opencv", config = config)
    if "pango" not in excludes:
        pango_repository(name = "pango")
    if "pcre" not in excludes:
        pcre_repository(name = "pcre")
    if "pixman" not in excludes:
        pixman_repository(name = "pixman")
    if "python" not in excludes:
        python_repository(name = "python")
    if "snappy" not in excludes:
        snappy_repository(name = "snappy")
    if "spdlog" not in excludes:
        spdlog_repository(name = "spdlog")
    if "util-linux" not in excludes:
        util_linux_repository(name = "util-linux")
    if "videoproto" not in excludes:
        videoproto_repository(name = "videoproto")
    if "x264" not in excludes:
        x264_repository(name = "x264")
    if "xcb-proto" not in excludes:
        xcb_proto_repository(name = "xcb-proto")
    if "xorgproto" not in excludes:
        xorgproto_repository(name = "xorgproto")
    if "xtrans" not in excludes:
        xtrans_repository(name = "xtrans")
    if "zlib" not in excludes:
        zlib_repository(name = "zlib")
