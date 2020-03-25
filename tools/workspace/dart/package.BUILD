# -*- python -*-

# Copyright 2019-2020 Josh Pieper, jjp@pobox.com.
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

package(default_visibility = ["//visibility:public"])

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

generate_file(
    name = "dart/config.hpp",
    content = """
#ifndef DART_CONFIG_HPP_
#define DART_CONFIG_HPP_

#include <Eigen/Core>

#define DART_MAJOR_VERSION 6
#define DART_MINOR_VERSION 9
#define DART_PATCH_VERSION 2

#define DART_VERSION_AT_LEAST(x,y,z) \
  (DART_MAJOR_VERSION > x || (DART_MAJOR_VERSION >= x && \
  (DART_MINOR_VERSION > y || (DART_MINOR_VERSION >= y && \
  DART_PATCH_VERSION >= z))))

#define DART_MAJOR_MINOR_VERSION_AT_LEAST(x,y) \
  (DART_MAJOR_VERSION > x || (DART_MAJOR_VERSION >= x && \
  (DART_MINOR_VERSION > y || (DART_MINOR_VERSION >= y))))

#define DART_VERSION_AT_MOST(x,y,z) \
  (DART_MAJOR_VERSION < x || (DART_MAJOR_VERSION <= x && \
  (DART_MINOR_VERSION < y || (DART_MINOR_VERSION <= y && \
  DART_PATCH_VERSION <= z))))

#define DART_MAJOR_MINOR_VERSION_AT_MOST(x,y) \
  (DART_MAJOR_VERSION < x || (DART_MAJOR_VERSION <= x && \
  (DART_MINOR_VERSION < y || (DART_MINOR_VERSION <= y))))

#define EIGEN_VERSION_AT_MOST(x,y,z) \
  (EIGEN_WORLD_VERSION < x || (EIGEN_WORLD_VERSION <= x && \
  (EIGEN_MAJOR_VERSION < y || (EIGEN_MAJOR_VERSION <= y && \
  EIGEN_MINOR_VERSION <= z))))

// Detect the compiler
#if defined(__clang__)
  #define DART_COMPILER_CLANG
#elif defined(__GNUC__) || defined(__GNUG__)
  #define DART_COMPILER_GCC
#elif defined(_MSC_VER)
  #define DART_COMPILER_MSVC
#endif

#endif
    """)

COMMON_COPTS = [
    "-DASSIMP_AISCENE_CTOR_DTOR_DEFINED",
    "-DASSIMP_AIMATERIAL_CTOR_DTOR_DEFINED",
    "-Wno-mismatched-tags",
    "-Wno-delete-non-abstract-non-virtual-dtor",
]

cc_library(
    name = "dart",
    hdrs = glob(["dart/**/*.hpp"]),
    srcs = [
        "dart/config.hpp",
        "dart/optimizer/Function.cpp",
        "dart/optimizer/Problem.cpp",
        "dart/optimizer/GradientDescentSolver.cpp",
        "dart/optimizer/Solver.cpp",
        "dart/utils/FileInfoWorld.cpp",
    ] + glob([
        "dart/external/odelcpsolver/*.cpp",
        "dart/external/odelcpsolver/*.h",
        "dart/collision/*.cpp",
        "dart/collision/fcl/*.cpp",
        "dart/common/**/*.cpp",
        "dart/constraint/**/*.cpp",
        "dart/dynamics/**/*.cpp",
        "dart/math/**/*.cpp",
        "dart/simulation/**/*.cpp",
    ], exclude = [
        # These need ikfast
        "dart/dynamics/IkFast.cpp",
        "dart/dynamics/SharedLibraryIkFast.cpp",
        "dart/gui/osg/**/*.cpp",
        "dart/gui/glut/**/*.cpp",
    ]),
    copts = COMMON_COPTS,
    deps = ["@assimp", "@boost", "@eigen", "@fcl"],
    includes = ["."],
)

# NOTE: This depends upon a system installed GLU and GL.
cc_library(
    name = "gui",
    srcs = [
        "dart/external/lodepng/lodepng.cpp",
        "dart/external/lodepng/lodepng.h",
    ] + glob([
        "dart/gui/**/*.cpp",
    ], exclude = [
        "dart/gui/osg/**/*.cpp",
    ]),
    copts = COMMON_COPTS,
    deps = [
        ":dart",
        "@freeglut",
    ],
    linkopts = ["-lGL", "-lGLU"],
)
