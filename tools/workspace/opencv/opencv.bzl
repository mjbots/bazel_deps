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

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")
load("@com_github_mjbots_bazel_deps//tools/workspace:template_file.bzl",
     "template_file")

_OPENCV_COPTS = [
    "-D_USE_MATH_DEFINES",
    "-D__OPENCV_BUILD=1",
    "-D__STDC_CONSTANT_MACROS",
    "-D__STDC_FORMAT_MACROS",
    "-D__STDC_LIMIT_MACROS",
    "-I$(GENDIR)/external/opencv/private/",
]

_KNOWN_OPTS = [
    ("neon", "armeabihf"),
    ("vfpv3", "armeabihf"),
    ("avx", "x86_64"),
    ("avx2", "x86_64"),
    ("avx512_skx", "x86_64"),
    ("cuda", "x86_64"),
    ("fp16", "x86_64"),
    ("fp16", "armeabihf"),
    ("sse", "x86_64"),
    ("sse2", "x86_64"),
    ("sse3", "x86_64"),
    ("sse4_1", "x86_64"),
    ("sse4_2", "x86_64"),
]

def _format_config(arch, opts):
    result = ""

    result += "\n".join(["""
#define CV_CPU_COMPILE_{opt} 1
#define CV_CPU_BASELINE_COMPILE_{opt} 1
""".format(opt=opt[0].upper()) for opt in _KNOWN_OPTS
                         if opt[1] == arch and opt[0] in opts])

    result += "#define CV_CPU_BASELINE_FEATURES 0 \\\n"

    result += "".join(["   , CV_CPU_{opt} \\\n".format(opt=opt[0].upper())
                       for opt in _KNOWN_OPTS
                       if opt[1] == arch and opt[0] in opts])

    result += "\n\n"

    return result

def opencv_base(config = None):
    generate_file(
        name = "private/version_string.inc",
        content = "\"\"",
    )

    generate_file(
        name = "opencv2/opencv_modules.hpp",
        content = "".join([
            "#define HAVE_OPENCV_{}\n".format(x.upper())
            for x in config["modules"]]),
    )

    generate_file(
        name = "custom_hal.hpp",
        content = """
#ifndef _CUSTOM_HAL_INCLUDED_
#define _CUSTOM_HAL_INCLUDED_

#endif
        """,
    )

    generate_file(
        name = "cv_cpu_config.h",
        content = select({
            "@com_github_mjbots_bazel_deps//conditions:arm" :
            _format_config("armeabihf", config.get("opts", [])),
            "@com_github_mjbots_bazel_deps//conditions:x86_64" :
            _format_config("x86_64", config.get("opts", [])),
        }),
    )

    template_file(
        name = "cvconfig.h",
        src = "cmake/templates/cvconfig.h.in",
        substitutions = {
            # We explicitly enumerate all the configs here so that
            # when upgrading opencv version we can be sure to notice
            # anything new that is added.
            "#cmakedefine BUILD_SHARED_LIBS" : "#define BUILD_SHARED_LIBS",
            "#cmakedefine CV_ENABLE_INTRINSICS" : "#define CV_ENABLE_INTRINSICS",
            "#cmakedefine CV_DISABLE_OPTIMIZATION" : "/* CV_DISABLE_OPTIMIZATION */",
            "${OPENCV_CUDA_ARCH_BIN}" : "\"\"",
            "#cmakedefine CUDA_ARCH_BIN_OR_PTX_10" : "/* CUDA_ARCH_BIN_OR_PTX_10 */",
            "${OPENCV_CUDA_ARCH_FEATURES}" : "\"\"",
            "${OPENCV_CUDA_ARCH_PTX}" : "\"\"",
            "#cmakedefine HAVE_AVFOUNDATION" : "/* HAVE_AVFOUNDATION */",
            "#cmakedefine HAVE_CAMV4L\n" : "/* HAVE_CAMV4L */\n",
            "#cmakedefine HAVE_CAMV4L2" : "#define HAVE_CAMV4L2",
            "#cmakedefine HAVE_CARBON" : "/* HAVE_CARBON */",
            "#cmakedefine HAVE_CLAMDBLAS" : "/* HAVE_CLAMDBLAS */",
            "#cmakedefine HAVE_CLAMDFFT" : "/* HAVE_CLAMDFFT */",
            "#cmakedefine HAVE_CLP" : "/* HAVE_CLP */",
            "#cmakedefine HAVE_COCOA" : "/* HAVE_COCOA */",
            "#cmakedefine HAVE_CSTRIPES" : "/* HAVE_CSTRIPES */",
            "#cmakedefine HAVE_CUBLAS" : "/* HAVE_CUBLAS */",
            "#cmakedefine HAVE_CUDA" : "/* HAVE_CUDA */",
            "#cmakedefine HAVE_CUFFT" : "/* HAVE_CUFFT */",
            "#cmakedefine HAVE_DC1394\n" : "/* HAVE_DC1394 */\n",
            "#cmakedefine HAVE_DC1394_2" : "/* HAVE_DC1394_2 */",
            "#cmakedefine HAVE_DIRECTX\n" : "/* HAVE_DIRECTX */\n",
            "#cmakedefine HAVE_DIRECTX_NV12" : "/* HAVE_DIRECTX_NV12 */",
            "#cmakedefine HAVE_D3D11" : "/* HAVE_D3D11 */",
            "#cmakedefine HAVE_D3D10" : "/* HAVE_D3D10 */",
            "#cmakedefine HAVE_D3D9" : "/* HAVE_D3D9 */",
            "#cmakedefine HAVE_DSHOW" : "/* HAVE_DSHOW */",
            "#cmakedefine HAVE_EIGEN" : "#define HAVE_EIGEN",
            "#cmakedefine HAVE_FFMPEG" : "#define HAVE_FFMPEG",
            "#cmakedefine HAVE_GDAL" : "/* HAVE_GDAL */",
            "#cmakedefine HAVE_GSTREAMER" : "/* HAVE_GSTREAMER */",
            "#cmakedefine HAVE_GTHREAD" : "#define HAVE_GTHREAD",
            "#cmakedefine HAVE_GTK" : "/* HAVE_GTK */",
            "#cmakedefine HAVE_HALIDE" : "/* HAVE_HALIDE */",
            "#cmakedefine HAVE_INTTYPES_H 1" : "/* HAVE_INTTYPES_H */",
            "#cmakedefine HAVE_INTELPERC" : "/* HAVE_INTELPERC */",
            "#cmakedefine HAVE_IPP\n" : "/* HAVE_IPP */\n",
            "#cmakedefine HAVE_IPP_ICV" : "/* HAVE_IPP_ICV */",
            "#cmakedefine HAVE_IPP_IW" : "/* HAVE_IPP_IW */",
            "#cmakedefine HAVE_IPP_A" : "/* HAVE_IPP_A */",
            "#cmakedefine HAVE_JASPER" : "/* HAVE_JASPER */",
            "#cmakedefine HAVE_JPEG" : "#define HAVE_JPEG 1",
            "#cmakedefine HAVE_LIBPNG_PNG_H" : "#define HAVE_LIBPNG_PNG_H 1",
            "#cmakedefine HAVE_GDCM" : "/* HAVE_GDCM */",
            "#cmakedefine HAVE_LIBV4L" : "/* HAVE_LIBV4L */",
            "#cmakedefine HAVE_MSMF" : "/* HAVE_MSMF */",
            "#cmakedefine HAVE_NVCUVID" : "/* HAVE_NVCUVID */",
            "#cmakedefine HAVE_NVCUVENC" : "/* HAVE_NVCUVENC */",
            "#cmakedefine HAVE_OPENCL\n" : "/* HAVE_OPENCL */\n",
            "#cmakedefine HAVE_OPENCL_STATIC" : "/* HAVE_OPENCL_STATIC */",
            "#cmakedefine HAVE_OPENCL_SVM" : "/* HAVE_OPENCL_SVM */",
            "#cmakedefine HAVE_OPENEXR" : "/* HAVE_OPENEXR */",
            "#cmakedefine HAVE_OPENGL" : "/* HAVE_OPENGL */",
            "#cmakedefine HAVE_OPENNI\n" : "/* HAVE_OPENNI */\n",
            "#cmakedefine HAVE_OPENNI2" : "/* HAVE_OPENNI2 */",
            "#cmakedefine HAVE_PNG" : "#define HAVE_PNG 1",
            "#cmakedefine HAVE_PTHREAD" : "#define HAVE_PTHREAD",
            "#cmakedefine HAVE_PTHREADS_PF" : "#define HAVE_PTHREADS_PF",
            "#cmakedefine HAVE_QT\n" : "/* HAVE_QT */\n",
            "#cmakedefine HAVE_QT_OPENGL" : "/* HAVE_QT_OPENGL */",
            "#cmakedefine HAVE_QUICKTIME" : "/* HAVE_QUICKTIME */",
            "#cmakedefine HAVE_QTKIT" : "/* HAVE_QTKIT */",
            "#cmakedefine HAVE_TBB" : "/* HAVE_TBB */",
            "#cmakedefine HAVE_TIFF" : "/* HAVE_TIFF */",
            "#cmakedefine HAVE_UNICAP" : "/* HAVE_UNICAP */",
            "#cmakedefine HAVE_VFW" : "/* HAVE_VFW */",
            "#cmakedefine HAVE_VIDEOIO" : "/* HAVE_VIDEOIO */",
            "#cmakedefine HAVE_WIN32UI" : "/* HAVE_WIN32UI */",
            "#cmakedefine HAVE_XIMEA" : "/* HAVE_XIMEA */",
            "#cmakedefine HAVE_XINE" : "/* HAVE_XINE */",
            "#cmakedefine WORDS_BIGENDIAN" : "/* WORDS_BIGENDIAN */",
            "#cmakedefine HAVE_GPHOTO2" : "/* HAVE_GPHOTO2 */",
            "#cmakedefine HAVE_VA\n" : "/* HAVE_VA */\n",
            "#cmakedefine HAVE_VA_INTEL" : "/* HAVE_VA_INTEL */",
            "#cmakedefine HAVE_MFX" : "/* HAVE_MFX */",
            "#cmakedefine HAVE_LAPACK" : "/* HAVE_LAPACK */",
            "#cmakedefine ENABLE_INSTRUMENTATION" : "/* ENABLE_INSTRUMENTATION */",
            "#cmakedefine HAVE_OPENVX" : "/* HAVE_OPENVX */",
            "#cmakedefine OPENCV_TRACE" : "#define OPENCV_TRACE",
        },
    )


    native.cc_library(
        name = "_base_headers",
        hdrs = [
            "cvconfig.h",
            "cv_cpu_config.h",
            "custom_hal.hpp",
            "opencv2/opencv_modules.hpp",
        ],
        textual_hdrs = [
            "private/version_string.inc",
        ],
    )

    native.cc_library(
        name = "opencv",
        deps = [":{}".format(module) for module in config['modules']],
    )

def opencv_module(*args, name = None, config = None,
                  excludes = None, dispatched_files = None,
                  deps = None,
                  copts = []):
    prefix = "modules/{}".format(name)

    config = config or []
    deps = deps or []
    excludes = excludes or []
    dispatched_files = dispatched_files or {}

    enabled_opts = config.get("opts", [])

    extra_headers = []
    extra_sources = []

    # TODO: Do dispatched files.

    for fname, opts in dispatched_files.items():
        simd_declarations = prefix + "/src/{}.simd_declarations.hpp".format(fname)
        simd_filename = prefix + "/src/{}.simd.hpp".format(fname)

        generate_file(
            name = simd_declarations,
            content = (
                "#define CV_CPU_SIMD_FILENAME \"{}\"\n".format(simd_filename) +
                '\n'.join([
                    ("#define CV_CPU_DISPATCH_MODE {}\n" +
                     "#include \"opencv2/core/private/cv_cpu_include_simd_declarations.hpp\"\n").format(opt.upper())
                    for opt in opts]) +
                "\n#define CV_CPU_DISPATCH_MODES_ALL " + ", ".join([x.upper() for x in reversed(opts) + ["BASELINE"]]) + "\n"),
        )

        extra_sources += [simd_declarations]

    # For now, we just stub out opencl as all empty and don't actually
    # support it.
    cl_sources = native.glob([prefix + "/src/opencl/*.cl"])
    if len(cl_sources):
        header_file = prefix + "/src/opencl_kernels_{}.hpp".format(name)
        generate_file(
            name = header_file,
            content = """
#include "opencv2/core/ocl.hpp"
#include "opencv2/core/ocl_genbase.hpp"
#include "opencv2/core/opencl/ocl_defs.hpp"
            """)
        extra_headers += [ header_file ]

    native.cc_library(
        name = name,
        srcs = native.glob([
            prefix + "/src/**/*.cpp",
            prefix + "/src/**/*.hpp",
            prefix + "/src/**/*.h",
        ], exclude = excludes + [
            prefix + "/src/**/*.{}.cpp".format(x[0]) for x in _KNOWN_OPTS
            if x not in enabled_opts
        ]) + extra_sources,
        hdrs = native.glob([
            prefix + "/include/**/*.h",
            prefix + "/include/**/*.hpp",
        ]) + extra_headers,
        deps = ["{}".format(x) for x in deps] + [":_base_headers"],
        includes = [prefix + "/include"],
        copts = _OPENCV_COPTS + [
            "-Iexternal/opencv/" + prefix + "/src",
            "-I$(GENDIR)/external/opencv/" + prefix + "/src",
        ] + copts,
    )
