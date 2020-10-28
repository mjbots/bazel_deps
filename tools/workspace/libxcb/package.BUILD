# -*- python -*-

# Copyright 2018-2020 Josh Pieper, jjp@pobox.com.
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

EXTENSIONS = [
    "bigreq",
    "composite",
    "damage",
    "dpms",
    "dri2",
    "dri3",
    "ge",
    "glx",
    "present",
    "randr",
    "record",
    "render",
    "res",
    "screensaver",
    "shape",
    "shm",
    "sync",
    "xc_misc",
    "xevie",
    "xf86dri",
    "xf86vidmode",
    "xfixes",
    "xinerama",
    "xinput",
    "xkb",
    "xprint",
    "xproto",
    "xtest",
    "xvmc",
    "xv",
]

py_binary(
    name = "c_client",
    srcs = ["src/c_client.py"],
    deps = [
        "@xcb-proto//:py_xcbgen",
    ],
    data = [
        "@xcb-proto//:xml",
    ],
)

[genrule(
    name = "c_client_{}".format(extension),
    tools = [
        "c_client",
        "@xcb-proto//:xcbgen/state.py",
        "@xcb-proto//:py_xcbgen",
    ],
    srcs = [
        "@xcb-proto//:src/{}.xml".format(extension),
        "@xcb-proto//:xml",
    ],
    outs = [
        "{}.c".format(extension),
        "{}.h".format(extension),
    ],
    cmd = ('$(location c_client) -c "libxcb 1.13" ' +
           '-l "X Version 11" ' +
           '-s "3" ' +
           '-p $$(dirname $(location @xcb-proto//:xcbgen/state.py)) ' +
           '$(location @xcb-proto//:src/{extension}.xml) && ' +
           'mv {extension}.c $(location {extension}.c) && ' +
           'mv {extension}.h $(location {extension}.h)').format(
               extension=extension),
) for extension in EXTENSIONS]


[genrule(
    name = "headermove_{}".format(x),
    outs = ["xcb/{}".format(x)],
    srcs = ["src/{}".format(x)],
    cmd = "cp $< $@",
) for x in ["xcb.h", "xcbext.h"]]

cc_library(
    name = "libxcb",
    hdrs = (
        ["{}.h".format(x) for x in EXTENSIONS] +
        ["xcb/" + x for x in [
            "xcb.h",
            "xcbext.h",
        ]]
    ),
    srcs = (
        ["{}.c".format(x) for x in EXTENSIONS] +
        ["src/" + x for x in [
            "xcb_conn.c",
            "xcb_out.c",
            "xcb_in.c",
            "xcb_ext.c",
            "xcb_xid.c",
            "xcb_list.c",
            "xcb_util.c",
            "xcb_auth.c",
            "xcbint.h",
        ]] + [
            "private/config.h",
        ]
    ),
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/libxcb/private",
        "-I$(GENDIR)/external/libxcb/xcb",
        "-Iexternal/libxcb/src",
    ] + select({
    "@com_github_mjbots_bazel_deps//conditions:gcc" : [
        "-Wno-unused-but-set-variable",
    ],
    "@com_github_mjbots_bazel_deps//conditions:clang" : [
        "-Wno-macro-redefined",
        "-Wno-unused-result",
        "-Wno-unused-parameter",
        "-Wno-vla",
        "-Wno-sign-compare",
    ]}),
    includes = [".", "xcb"],
    deps = [
        "@libxau",
        "@libxdmcp",
    ],
)

autoconf_config(
    name = "private/config.h",
    src = "src/config.h.in",
    package = "libxcb",
    version = "1.13.0",
    defines = autoconf_standard_defines + [
        "GCC_HAS_VISIBILITY",
        "HASXDMAUTH",
        "USE_POLL",
        "XCB_QUEUE_BUFFER_SIZE=16384",
        "IOV_MAX=1024",
    ],
)
