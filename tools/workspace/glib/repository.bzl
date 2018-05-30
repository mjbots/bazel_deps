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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def glib_repository(name):
    http_archive(
        name = name,
        urls = [
            "https://ftp.gnome.org/pub/gnome/sources/glib/2.57/glib-2.57.1.tar.xz",
        ],
        sha256 = "d029e7c4536835f1f103472f7510332c28d58b9b7d6cd0e9f45c2653e670d9b4",
        strip_prefix = "glib-2.57.1",
        build_file = Label("//tools/workspace/glib:package.BUILD"),
    )
