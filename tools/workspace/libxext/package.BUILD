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
    name = "libxext",
    hdrs = ["include/X11/extensions/" + x for x in [
        "dpms.h",
	"extutil.h",
	"MITMisc.h",
	"multibuf.h",
	"security.h",
	"shape.h",
	"sync.h",
	"Xag.h",
	"Xcup.h",
	"Xdbe.h",
	"XEVI.h",
	"Xext.h",
	"Xge.h",
	"XLbx.h",
	"XShm.h",
	"xtestext1.h",
    ]],
    srcs = ["src/" + x for x in [
	"DPMS.c",
	"MITMisc.c",
	"XAppgroup.c",
	"XEVI.c",
	"XLbx.c",
	"XMultibuf.c",
	"XSecurity.c",
	"XShape.c",
	"XShm.c",
	"XSync.c",
	"XTestExt1.c",
	"Xcup.c",
	"Xdbe.c",
        "Xge.c",
	"extutil.c",
	"globals.c",
    ]] + [
        "private/config.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/libxext/private",
    ],
    includes = ["include"],
    deps = [
        "@libx11",
    ],
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "libXext",
    version = "1.3.3",
    defines = autoconf_standard_defines + [
    ],
)
