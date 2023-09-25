# -*- python -*-

# Copyright 2023 mjbots Robotic Systems, LLC.  info@mjbots.com
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
    name = "libxdmcp",
    hdrs = ["include/X11/Xdmcp.h"],
    srcs = [
        "Array.c",
        "Fill.c",
        "Flush.c",
        "Key.c",
        "Read.c",
        "Unwrap.c",
        "Wrap.c",
        "Wraphelp.c",
        "Write.c",
        "Wrap.h",
        "private/config.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/libxdmcp/private",
    ],
    includes = ["include"],
    deps = [
        "@xorgproto",
    ],
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "libXdmcp",
    version = "1.1.2",
    defines = autoconf_standard_defines +[
        "HASXDMAUTH",
    ],
)
