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

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "libxau",
    hdrs = ["include/X11/Xauth.h"],
    srcs = [
        "AuDispose.c",
        "AuFileName.c",
        "AuGetAddr.c",
        "AuGetBest.c",
        "AuLock.c",
        "AuRead.c",
        "AuUnlock.c",
        "AuWrite.c",
        "private/config.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/libxau/private",
    ],
    includes = ["include"],
    deps = [
        "@xorgproto",
    ],
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "libXau",
    version = "1.0.8",
    defines = autoconf_standard_defines + [
        "XTHREADS",
        "XUSE_MTSAFE_API",
    ],
)
