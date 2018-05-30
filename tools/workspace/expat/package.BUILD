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
    name = "expat",
    hdrs = [
        "lib/expat.h",
        "lib/expat_external.h",
        "expat_config.h",
    ],
    srcs = ["lib/" + x for x in [
        "loadlibrary.c",
        "xmlparse.c",
        "xmltok.c",
        "xmlrole.c",

        "ascii.h",
        "asciitab.h",
        "expat_external.h",
        "expat.h",
        "iasciitab.h",
        "internal.h",
        "latin1tab.h",

        "siphash.h",
        "utf8tab.h",
        "winconfig.h",
        "xmlrole.h",
        "xmltok.h",
        "xmltok_impl.h",

    ]],
    textual_hdrs = [
        "lib/libexpat.def",
        "lib/libexpatw.def",
        "lib/nametab.h",
        "lib/xmltok_impl.c",
        "lib/xmltok_ns.c",
    ],
    includes = [".", "lib"],
    copts = [
        "-DHAVE_CONFIG_H",
        "-DHAVE_EXPAT_CONFIG_H",
    ],
)

autoconf_config(
    name = "expat_config.h",
    src = "expat_config.h.in",
    package = "expat",
    version = "2.2.5",
    defines = autoconf_standard_defines + [
        "BYTEORDER=1234",
        "XML_CONTENT_BYTES=1024",
        "XML_DEV_URANDOM",
        "XML_DTD",
        "XML_NS",
    ],
)
