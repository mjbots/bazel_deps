# Open-source bazel build file collection #

This contains a set of open source packages configured to build within
the bazel (https://bazel.build) build system.  Packages include:

 * opencv
 * ffmpeg (and many codecs)
 * gstreamer (and many of its plugins, including X output)
 * eigen
 * boost
 * python
 * fmt

Currently supported platforms are x86_64 and armv7.

 - travis-ci [![Build Status](https://travis-ci.org/mjbots/bazel_deps.svg?branch=master)](https://travis-ci.org/mjbots/bazel_deps)

## Example Usage ##

In `tools/workspace/bazel_deps/repository.bzl`

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


def bazel_deps_repository():
    commit = "XXX"
    http_archive(
        name = "com_github_mjbots_bazel_deps",
        url = "https://github.com/mjbots/bazel_deps/archive/{}.zip".format(commit),
        # Try the following empty sha256 hash first, then replace with whatever
        # bazel says it is looking for once it complains.
        sha256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
        strip_prefix = "bazel_deps-{}".format(commit),
    )
```

At least an empty `tools/workspace/bazel_deps/BUILD` is required.

In `tools/workspace/default.bzl`

```
load("//tools/workspace/bazel_deps:repository.bzl", "bazel_deps_repository")

def add_default_repositories(excludes = []):
    if "bazel_deps" not in excludes:
        bazel_deps_repository()
```

At least an empty `tools/workspace/BUILD` is required.

In `WORKSPACE`:

```
load("//tools/workspace:default.bzl", "add_default_repositories")

add_default_repositories()

load("@com_github_mjbots_bazel_deps//tools/workspace:default.bzl",
     bazel_deps_add = "add_default_repositories")
bazel_deps_add()
```

At this point, each of the relevant packages can be referenced in
bazel rules as is typical:

```
cc_binary(
    name = "my_application",
    deps = ["@ffmpeg"],
)
```
