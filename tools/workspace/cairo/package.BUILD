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

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")
load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")
load("@com_github_mjbots_bazel_deps//tools/workspace:autoconf_config.bzl",
     "autoconf_config", "autoconf_standard_defines")

package(default_visibility = ["//visibility:public"])

_CAIRO_FONT_SUBSET_PRIVATE = [
    "cairo-scaled-font-subsets-private.h",
    "cairo-truetype-subset-private.h",
    "cairo-type1-private.h",
    "cairo-type3-glyph-surface-private.h",
]

_CAIRO_FONT_SUBSET_SOURCES = [
    "cairo-cff-subset.c",
    "cairo-scaled-font-subsets.c",
    "cairo-truetype-subset.c",
    "cairo-type1-fallback.c",
    "cairo-type1-glyph-names.c",
    "cairo-type1-subset.c",
    "cairo-type3-glyph-surface.c",
]

_CAIRO_PDF_OPERATORS_PRIVATE = [
    "cairo-pdf-operators-private.h",
    "cairo-pdf-shading-private.h",
]

_CAIRO_PDF_OPERATORS_SOURCES = [
    "cairo-pdf-operators.c",
    "cairo-pdf-shading.c",
]

_CAIRO_DEFLATE_STREAM_SOURCES = [
    "cairo-deflate-stream.c",
]

_CAIRO_FT_HEADERS = [
    "cairo-ft.h",
]

_CAIRO_FT_PRIVATE = [
    "cairo-ft-private.h",
]

_CAIRO_FT_SOURCES = [
    "cairo-ft-font.c",
]

_CAIRO_SCRIPT_HEADERS = [
    "cairo-script.h",
]

_CAIRO_SCRIPT_PRIVATE = [
    "cairo-script-private.h",
]

_CAIRO_SCRIPT_SOURCES = [
    "cairo-script-surface.c",
]

_CAIRO_TEE_HEADERS = [
    "cairo-tee.h",
]

_CAIRO_TEE_PRIVATE = [
    "cairo-tee-surface-private.h",
]

_CAIRO_TEE_SOURCES = [
    "cairo-tee-surface.c",
]

CAIRO_HEADERS = [
    "cairo.h",
    "cairo-deprecated.h",
] + _CAIRO_FT_HEADERS + _CAIRO_SCRIPT_HEADERS + _CAIRO_TEE_HEADERS

CAIRO_PRIVATE = [
    "cairoint.h",
    "cairo-analysis-surface-private.h",
    "cairo-arc-private.h",
    "cairo-array-private.h",
    "cairo-atomic-private.h",
    "cairo-backend-private.h",
    "cairo-box-inline.h",
    "cairo-boxes-private.h",
    "cairo-cache-private.h",
    "cairo-clip-inline.h",
    "cairo-clip-private.h",
    "cairo-combsort-inline.h",
    "cairo-compiler-private.h",
    "cairo-compositor-private.h",
    "cairo-contour-inline.h",
    "cairo-contour-private.h",
    "cairo-composite-rectangles-private.h",
    "cairo-damage-private.h",
    "cairo-default-context-private.h",
    "cairo-device-private.h",
    "cairo-error-inline.h",
    "cairo-error-private.h",
    "cairo-fixed-private.h",
    "cairo-fixed-type-private.h",
    "cairo-freelist-private.h",
    "cairo-freelist-type-private.h",
    "cairo-freed-pool-private.h",
    "cairo-fontconfig-private.h",
    "cairo-gstate-private.h",
    "cairo-hash-private.h",
    "cairo-image-info-private.h",
    "cairo-image-surface-inline.h",
    "cairo-image-surface-private.h",
    "cairo-line-inline.h",
    "cairo-line-private.h",
    "cairo-list-inline.h",
    "cairo-list-private.h",
    "cairo-malloc-private.h",
    "cairo-mempool-private.h",
    "cairo-mutex-impl-private.h",
    "cairo-mutex-list-private.h",
    "cairo-mutex-private.h",
    "cairo-mutex-type-private.h",
    "cairo-output-stream-private.h",
    "cairo-paginated-private.h",
    "cairo-paginated-surface-private.h",
    "cairo-path-fixed-private.h",
    "cairo-path-private.h",
    "cairo-pattern-inline.h",
    "cairo-pattern-private.h",
    "cairo-pixman-private.h",
    "cairo-private.h",
    "cairo-recording-surface-inline.h",
    "cairo-recording-surface-private.h",
    "cairo-reference-count-private.h",
    "cairo-region-private.h",
    "cairo-rtree-private.h",
    "cairo-scaled-font-private.h",
    "cairo-slope-private.h",
    "cairo-spans-private.h",
    "cairo-spans-compositor-private.h",
    "cairo-stroke-dash-private.h",
    "cairo-surface-inline.h",
    "cairo-surface-private.h",
    "cairo-surface-backend-private.h",
    "cairo-surface-clipper-private.h",
    "cairo-surface-fallback-private.h",
    "cairo-surface-observer-inline.h",
    "cairo-surface-observer-private.h",
    "cairo-surface-offset-private.h",
    "cairo-surface-subsurface-inline.h",
    "cairo-surface-subsurface-private.h",
    "cairo-surface-snapshot-inline.h",
    "cairo-surface-snapshot-private.h",
    "cairo-surface-wrapper-private.h",
    "cairo-time-private.h",
    "cairo-types-private.h",
    "cairo-traps-private.h",
    "cairo-tristrip-private.h",
    "cairo-user-font-private.h",
    "cairo-wideint-private.h",
    "cairo-wideint-type-private.h",
] + _CAIRO_FONT_SUBSET_PRIVATE + _CAIRO_PDF_OPERATORS_PRIVATE + _CAIRO_FT_PRIVATE + _CAIRO_SCRIPT_PRIVATE + _CAIRO_TEE_PRIVATE

CAIRO_SOURCES = [
    "cairo-analysis-surface.c",
    "cairo-arc.c",
    "cairo-array.c",
    "cairo-atomic.c",
    "cairo-base64-stream.c",
    "cairo-base85-stream.c",
    "cairo-bentley-ottmann.c",
    "cairo-bentley-ottmann-rectangular.c",
    "cairo-bentley-ottmann-rectilinear.c",
    "cairo-botor-scan-converter.c",
    "cairo-boxes.c",
    "cairo-boxes-intersect.c",
    "cairo.c",
    "cairo-cache.c",
    "cairo-clip.c",
    "cairo-clip-boxes.c",
    "cairo-clip-polygon.c",
    "cairo-clip-region.c",
    "cairo-clip-surface.c",
    "cairo-color.c",
    "cairo-composite-rectangles.c",
    "cairo-compositor.c",
    "cairo-contour.c",
    "cairo-damage.c",
    "cairo-debug.c",
    "cairo-default-context.c",
    "cairo-device.c",
    "cairo-error.c",
    "cairo-fallback-compositor.c",
    "cairo-fixed.c",
    "cairo-font-face.c",
    "cairo-font-face-twin.c",
    "cairo-font-face-twin-data.c",
    "cairo-font-options.c",
    "cairo-freelist.c",
    "cairo-freed-pool.c",
    "cairo-gstate.c",
    "cairo-hash.c",
    "cairo-hull.c",
    "cairo-image-compositor.c",
    "cairo-image-info.c",
    "cairo-image-source.c",
    "cairo-image-surface.c",
    "cairo-line.c",
    "cairo-lzw.c",
    "cairo-matrix.c",
    "cairo-mask-compositor.c",
    "cairo-mesh-pattern-rasterizer.c",
    "cairo-mempool.c",
    "cairo-misc.c",
    "cairo-mono-scan-converter.c",
    "cairo-mutex.c",
    "cairo-no-compositor.c",
    "cairo-observer.c",
    "cairo-output-stream.c",
    "cairo-paginated-surface.c",
    "cairo-path-bounds.c",
    "cairo-path.c",
    "cairo-path-fill.c",
    "cairo-path-fixed.c",
    "cairo-path-in-fill.c",
    "cairo-path-stroke.c",
    "cairo-path-stroke-boxes.c",
    "cairo-path-stroke-polygon.c",
    "cairo-path-stroke-traps.c",
    "cairo-path-stroke-tristrip.c",
    "cairo-pattern.c",
    "cairo-pen.c",
    "cairo-polygon.c",
    "cairo-polygon-intersect.c",
    "cairo-polygon-reduce.c",
    "cairo-raster-source-pattern.c",
    "cairo-recording-surface.c",
    "cairo-rectangle.c",
    "cairo-rectangular-scan-converter.c",
    "cairo-region.c",
    "cairo-rtree.c",
    "cairo-scaled-font.c",
    "cairo-shape-mask-compositor.c",
    "cairo-slope.c",
    "cairo-spans.c",
    "cairo-spans-compositor.c",
    "cairo-spline.c",
    "cairo-stroke-dash.c",
    "cairo-stroke-style.c",
    "cairo-surface.c",
    "cairo-surface-clipper.c",
    "cairo-surface-fallback.c",
    "cairo-surface-observer.c",
    "cairo-surface-offset.c",
    "cairo-surface-snapshot.c",
    "cairo-surface-subsurface.c",
    "cairo-surface-wrapper.c",
    "cairo-time.c",
    "cairo-tor-scan-converter.c",
    "cairo-tor22-scan-converter.c",
    "cairo-clip-tor-scan-converter.c",
    "cairo-toy-font-face.c",
    "cairo-traps.c",
    "cairo-tristrip.c",
    "cairo-traps-compositor.c",
    "cairo-unicode.c",
    "cairo-user-font.c",
    "cairo-version.c",
    "cairo-wideint.c",
] + _CAIRO_FONT_SUBSET_SOURCES + _CAIRO_PDF_OPERATORS_SOURCES + _CAIRO_DEFLATE_STREAM_SOURCES + _CAIRO_FT_SOURCES + _CAIRO_SCRIPT_SOURCES

cc_library(
    name = "cairo",
    hdrs = ["src/" + x for x in CAIRO_HEADERS],
    srcs = ["src/" + x for x in (CAIRO_PRIVATE + CAIRO_SOURCES)] + [
        "cairo-version.h",
        "private/config.h",
        "src/cairo-features.h",
    ],
    includes = ["src"],
    copts = [
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/cairo/private",
        "-Wno-attributes",
        "-Wno-unused-function",
    ] + select({
        "@com_github_mjbots_bazel_deps//conditions:gcc" : [
            "-Wno-unused-but-set-variable",
        ],
        "@com_github_mjbots_bazel_deps//conditions:clang" : [
            "-Wno-enum-conversion",
            "-Wno-parentheses-equality",
            "-Wno-tautological-constant-out-of-range-compare",
        ],
        "//conditions:default" : [],
    }),
    deps = [
        "@zlib",
        "@freetype",
        "@pixman",
        "@fontconfig",
    ],
)

generate_file(
    name = "src/cairo-features.h",
    content = """
#ifndef CAIRO_FEATURES_H
#define CAIRO_FEATURES_H

#define CAIRO_HAS_FC_FONT 1
#define CAIRO_HAS_FT_FONT 1
#define CAIRO_HAS_GOBJECT_FUNCTIONS 1
#define CAIRO_HAS_IMAGE_SURFACE 1
#define CAIRO_HAS_MIME_SURFACE 1
#define CAIRO_HAS_OBSERVER_SURFACE 1
#define CAIRO_HAS_PDF_SURFACE 1
#define CAIRO_HAS_PNG_FUNCTIONS 1
#define CAIRO_HAS_PS_SURFACE 1
#define CAIRO_HAS_RECORDING_SURFACE 1
#define CAIRO_HAS_SCRIPT_SURFACE 1
#define CAIRO_HAS_SVG_SURFACE 1
#define CAIRO_HAS_USER_FONT 1
#endif
    """)

generate_file(
    name = "cairo-version.h",
    content = """
    #ifndef CAIRO_VERSION_H
#define CAIRO_VERSION_H

#define CAIRO_VERSION_MAJOR 1
#define CAIRO_VERSION_MINOR 14
#define CAIRO_VERSION_MICRO 12

#endif
    """)

autoconf_config(
    name = "private/config.h",
    src = "config.h.in",
    package = "cairo",
    version = "XXXX",
    defines = autoconf_standard_defines + [
        "CAIRO_HAS_DLSYM",
        "CAIRO_HAS_INTERPRETER",
        "CAIRO_HAS_PTHREAD",
        "CAIRO_HAS_REAL_PTHREAD",
        "CAIRO_HAS_TRACE",
        "HAS_PIXMAN_GLYPHS",
        "HAVE_FT_GET_X11_FONT_FORMAT",
        "HAVE_FT_GLYPHSLOT_EMBOLDEN",
        "HAVE_FT_GLYPHSLOT_OBLIQUE",
        "HAVE_FT_LIBRARY_SETLCDFILTER",
        "HAVE_FT_LOAD_SFNT_TABLE",
        "SHARED_LIB_EXT=\"so\"",
    ],
)
