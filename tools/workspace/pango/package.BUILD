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

pango_sources = ["pango/" + x for x in [
    'break.c',
    'ellipsize.c',
    'fonts.c',
    'glyphstring.c',
    'modules.c',
    'pango-attributes.c',
    'pango-bidi-type.c',
    'pango-color.c',
    'pango-context.c',
    'pango-coverage.c',
    'pango-emoji.c',
    'pango-engine.c',
    'pango-fontmap.c',
    'pango-fontset.c',
    'pango-glyph-item.c',
    'pango-gravity.c',
    'pango-item.c',
    'pango-language.c',
    'pango-layout.c',
    'pango-markup.c',
    'pango-matrix.c',
    'pango-renderer.c',
    'pango-script.c',
    'pango-tabs.c',
    'pango-utils.c',
    'reorder-items.c',
    'shape.c',
    'pango-script-private.h',
    'pango-impl-utils.h',
    'pango-engine-private.h',
    'pango-layout-private.h',
    'pango-utils-internal.h',
    'pango-emoji-private.h',
    'pango-color-table.h',
    'pango-emoji-table.h',
    'pango-language-sample-table.h',
    'pango-script-lang-table.h',

    'pangocairo-context.c',
    'pangocairo-font.c',
    'pangocairo-fontmap.c',
    'pangocairo-render.c',
    'pangocairo-private.h',

    'pangocairo-fcfont.c',
    'pangocairo-fcfontmap.c',
    'pangocairo-fc.h',

    'pangofc-font.c',
    'pangofc-fontmap.c',
    'pangofc-decoder.c',
    'pangofc-shape.c',
    'pangoft2.c',

    'pangofc-private.h',
    'pangoft2.h',
    'pangoft2-private.h',
    'pangoft2-fontmap.c',
    'pangoft2-render.c',
    'pango-ot-private.h',
    'pango-ot-buffer.c',
    'pango-ot-info.c',
    'pango-ot-ruleset.c',
    'pango-ot-tag.c',

]]

pango_headers = ["pango/" + x for x in [
    'pango.h',
    'pango-attributes.h',
    'pango-bidi-type.h',
    'pango-break.h',
    'pango-context.h',
    'pango-coverage.h',
    'pango-engine.h',
    'pango-font.h',
    'pango-fontmap.h',
    'pango-fontset.h',
    'pango-glyph.h',
    'pango-glyph-item.h',
    'pango-gravity.h',
    'pango-item.h',
    'pango-language.h',
    'pango-layout.h',
    'pango-matrix.h',
    'pango-modules.h',
    'pango-renderer.h',
    'pango-script.h',
    'pango-tabs.h',
    'pango-types.h',
    'pango-utils.h',
    'pango-version-macros.h',

    'pangocairo.h',
]]

pango_ft2_headers = ["pango/" + x for x in [
    'pango-ot.h',
    'pangofc-font.h',
    'pangofc-fontmap.h',
    'pangofc-decoder.h',
    'pangoft2.h',

]]

cc_library(
    name = "pango",
    srcs = pango_sources + [
        "private/config.h",
        "pango/pango-features.h",
        "pango/pango-enum-types.c",
        "pango/pango-enum-types.h",
    ],
    textual_hdrs = glob(["pango/break-*.c"]),
    hdrs = pango_headers + pango_ft2_headers,
    includes = [".", "pango"],
    copts = [
        '-DG_LOG_DOMAIN=\\"Pango\\"',
        '-DG_LOG_USE_STRUCTURED=1',
        '-DPANGO_COMPILATION',
        '-DPANGO_ENABLE_BACKEND',
        '-DPANGO_ENABLE_ENGINE',
        '-DSYSCONFDIR=\\"/etc\\"',
        '-DLIBDIR=\\"/lib\\"',

        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/pango/private",
        "-I$(GENDIR)/external/pango/pango",

        "-Wno-deprecated-declarations",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:clang" : [
            "-Wno-enum-conversion",
        ],
        "//conditions:default" : [],
    }),
    deps = [
        "@glib",
        "@freetype",
        "@harfbuzz",
        "@fribidi",
        "@cairo",
    ],
)

genrule(
    name = "enums_h",
    srcs = pango_headers + ["pango/pango-enum-types.h.template"],
    tools = ["@glib//:glib-mkenums"],
    outs = ["pango/pango-enum-types.h"],
    cmd = (
        "$(location @glib//:glib-mkenums) " +
        "--template $(location pango/pango-enum-types.h.template) " +
        "$(SRCS) > $@"),
)

genrule(
    name = "enums_c",
    srcs = pango_headers + ["pango/pango-enum-types.c.template"],
    tools = ["@glib//:glib-mkenums"],
    outs = ["pango/pango-enum-types.c"],
    cmd = (
        "$(location @glib//:glib-mkenums) " +
        "--template $(location pango/pango-enum-types.c.template) " +
        "$(SRCS) > $@"),
)

template_file(
    name = "pango/pango-features.h",
    src = "pango/pango-features.h.meson",
    substitutions = {
        "#mesondefine PANGO_VERSION_MAJOR" : "#define PANGO_VERSION_MAJOR 1",
        "#mesondefine PANGO_VERSION_MINOR" : "#define PANGO_VERSION_MINOR 42",
        "#mesondefine PANGO_VERSION_MICRO" : "#define PANGO_VERSION_MICRO 1",
    },
)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "pango",
    version = "1.42.1",
    defines = autoconf_standard_defines + [
        "HAVE_CAIRO",
        "HAVE_CAIRO_FREETYPE",
        "HAVE_CAIRO_PDF",
        "HAVE_FCWEIGHTFROMOPENTYPEDOUBLE",
        "HAVE_FREETYPE",
        "PANGO_BINARY_AGE=4201",
        "PANGO_INTERFACE_AGE=1",
        "PANGO_VERSION_MAJOR=1",
        "PANGO_VERSION_MINOR=42",
        "PANGO_VERSION_MICRO=1",
        "_PANGO_EXTERN=__attribute__((visibility(\"default\"))) extern",
    ],
)
