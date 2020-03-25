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

package(default_visibility = ["//visibility:public"])

load("@com_github_mjbots_bazel_deps//tools/workspace:generate_file.bzl",
     "generate_file")

generate_file(
    name = "include/fcl/export.h",
    content = """
    #ifndef FCL_EXPORT_H
#define FCL_EXPORT_H

#ifdef FCL_STATIC_DEFINE
#  define FCL_EXPORT
#  define FCL_NO_EXPORT
#else
#  ifndef FCL_EXPORT
#    ifdef fcl_EXPORTS
        /* We are building this library */
#      define FCL_EXPORT __attribute__((visibility("default")))
#    else
        /* We are using this library */
#      define FCL_EXPORT __attribute__((visibility("default")))
#    endif
#  endif

#  ifndef FCL_NO_EXPORT
#    define FCL_NO_EXPORT __attribute__((visibility("hidden")))
#  endif
#endif

#ifndef FCL_DEPRECATED
#  define FCL_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef FCL_DEPRECATED_EXPORT
#  define FCL_DEPRECATED_EXPORT FCL_EXPORT FCL_DEPRECATED
#endif

#ifndef FCL_DEPRECATED_NO_EXPORT
#  define FCL_DEPRECATED_NO_EXPORT FCL_NO_EXPORT FCL_DEPRECATED
#endif

#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef FCL_NO_DEPRECATED
#    define FCL_NO_DEPRECATED
#  endif
#endif

#endif
""")

generate_file(
    name = "include/fcl/config.h",
    content = """
#ifndef FCL_CONFIG_H_
#define FCL_CONFIG_H_

#define FCL_VERSION "0.6.1"
#define FCL_MAJOR_VERSION 0
#define FCL_MINOR_VERSION 6
#define FCL_PATCH_VERSION 1

#define FCL_HAVE_SSE 0
#define FCL_HAVE_OCTOMAP 0

#define FCL_ENABLE_PROFILING 0

// Detect the operating systems
#if defined(__APPLE__)
  #define FCL_OS_MACOS
#elif defined(__gnu_linux__)
  #define FCL_OS_LINUX
#elif defined(_WIN32)
  #define FCL_OS_WINDOWS
#endif

// Detect the compiler
#if defined(__clang__)
  #define FCL_COMPILER_CLANG
#elif defined(__GNUC__) || defined(__GNUG__)
  #define FCL_COMPILER_GCC
#elif defined(_MSC_VER)
  #define FCL_COMPILER_MSVC
#endif

#if FCL_HAVE_OCTOMAP
  #define OCTOMAP_MAJOR_VERSION
  #define OCTOMAP_MINOR_VERSION
  #define OCTOMAP_PATCH_VERSION

  #define OCTOMAP_VERSION_AT_LEAST(x,y,z) \
    (OCTOMAP_MAJOR_VERSION > x || (OCTOMAP_MAJOR_VERSION >= x && \
    (OCTOMAP_MINOR_VERSION > y || (OCTOMAP_MINOR_VERSION >= y && \
    OCTOMAP_PATCH_VERSION >= z))))

  #define OCTOMAP_VERSION_AT_MOST(x,y,z) \
    (OCTOMAP_MAJOR_VERSION < x || (OCTOMAP_MAJOR_VERSION <= x && \
    (OCTOMAP_MINOR_VERSION < y || (OCTOMAP_MINOR_VERSION <= y && \
    OCTOMAP_PATCH_VERSION <= z))))
#endif  // FCL_HAVE_OCTOMAP

#endif
    """)

cc_library(
    name = "fcl",
    hdrs = glob(["include/fcl/**/*.h"]) + [
        "include/fcl/config.h",
        "include/fcl/export.h",
    ],
    srcs = glob(["src/**/*.cpp"]),
    deps = ["@eigen", "@libccd"],
    includes = ["include"],
)
