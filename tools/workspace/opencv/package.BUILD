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

load("@com_github_mjbots_bazel_deps//tools/workspace/opencv:opencv.bzl",
     "opencv_base", "opencv_module")

package(default_visibility = ["//visibility:public"])

CONFIG = {
    "modules" : [
        "aruco",
        "calib3d",
        "core",
        "imgcodecs",
        "imgproc",
    ],
    "opts" : @PROCESSOR_OPTS@,
}

opencv_base(config=CONFIG)

opencv_module(
    name = "core",
    config = CONFIG,
    dispatched_files = {
        "stat" : ["sse4_2", "avx"],
        "mathfuncs_core" : ["sse2", "avx", "avx2"],
    },
    deps = ["@eigen", "@zlib"],
)

opencv_module(
    name = "imgproc",
    config = CONFIG,
    dispatched_files = {
        "accum" : ["sse2", "avx", "neon"],
    },
    deps = [":core"],
)

opencv_module(
    name = "features2d",
    config = CONFIG,
    deps = [":imgproc"],
)

opencv_module(
    name = "calib3d",
    config = CONFIG,
    deps = [":imgproc", ":features2d"],
)

opencv_module(
    name = "imgcodecs",
    config = CONFIG,
    deps = [":core", ":imgproc", "@libjpeg", "@libpng"],
)

opencv_module(
    name = "aruco",
    config = CONFIG,
    deps = [":core", ":imgproc", ":calib3d"],
)
