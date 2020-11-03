# -*- python -*-

# Copyright 2020 Josh Pieper, jjp@pobox.com.
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
    name = "libxi",
    hdrs = ["include/X11/extensions/" + x for x in [
        "XInput2.h",
        "XInput.h",
    ]],
    srcs = ["src/" + x for x in [
        "XAllowDv.c",
        "XChDProp.c",
        "XChgDCtl.c",
        "XChgFCtl.c",
        "XChgKbd.c",
        "XChgKMap.c",
        "XChgPnt.c",
        "XChgProp.c",
        "XCloseDev.c",
        "XDelDProp.c",
        "XDevBell.c",
        "XExtInt.c",
        "XExtToWire.c",
        # This doesn't seem to even compile, and isn't necessary.
        # "XFreeLst.c",
        "XGetBMap.c",
        "XGetCPtr.c",
        "XGetDCtl.c",
        "XGetDProp.c",
        "XGetFCtl.c",
        "XGetKMap.c",
        "XGetMMap.c",
        "XGetProp.c",
        "XGetVers.c",
        "XGMotion.c",
        "XGrabDev.c",
        "XGrDvBut.c",
        "XGrDvKey.c",
        "XGtFocus.c",
        "XGtSelect.c",
        "XIAllowEvents.c",
        "XIBarrier.c",
        "XIDefineCursor.c",
        "XIGetDevFocus.c",
        "XIGrabDevice.c",
        "XIHierarchy.c",
        "XIint.h",
        "XIPassiveGrab.c",
        "XIProperties.c",
        "XIQueryDevice.c",
        "XIQueryPointer.c",
        "XIQueryVersion.c",
        "XISelEv.c",
        "XISetCPtr.c",
        "XISetDevFocus.c",
        "XIWarpPointer.c",
        "XListDev.c",
        "XListDProp.c",
        "XOpenDev.c",
        "XQueryDv.c",
        "XSelect.c",
        "XSetBMap.c",
        "XSetDVal.c",
        "XSetMMap.c",
        "XSetMode.c",
        "XSndExEv.c",
        "XStFocus.c",
        "XUngrDev.c",
        "XUngrDvB.c",
        "XUngrDvK.c",
    ]] + [
        "private/config.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-Iexternal/libxi/include/X11/extensions",
        "-I$(GENDIR)/external/libxi/private",
        "-Wno-sign-compare",
        "-Wno-unused-parameter",
    ],
    includes = ["include"],
    deps = [
        "@libx11",
    ],
    linkstatic = True,
)

autoconf_config(
    name = "private/config.h",
    src = "src/config.h.in",
    package = "libXi",
    version = "1.7.10",
    defines = autoconf_standard_defines + [
    ],
)
