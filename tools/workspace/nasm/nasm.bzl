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

def _impl(ctx):
    hdrs = [x for x in
            depset(transitive = [x.files for x in ctx.attr.textual_hdrs]).to_list()]
    force_includes = depset(transitive = [x.files for x in ctx.attr.force_includes])
    includes = depset(transitive = [x.files for x in ctx.attr.includes])

    outs = []

    for src in ctx.attr.srcs:
        for name in src.files.to_list():
            this_out = ctx.actions.declare_file(name.path.replace(".asm", ".o"))
            outs.append(this_out);

            ctx.actions.run(
                outputs = [this_out],
                mnemonic = "Assembling",
                progress_message = "Assembling " + name.path,
                inputs = [name] + hdrs + force_includes.to_list(),
                executable = ctx.attr._nasm.files.to_list()[0],
                arguments = (
                    ctx.attr.extra_args +
                    ["-I" + x.dirname + "/" for x in force_includes.to_list()] +
                    [
                        "-o", this_out.path,
                        name.path,
                    ] +
                    ["-P" + x.path for x in force_includes.to_list()]
                ),
            )

    return [DefaultInfo(
        files = depset(outs),
    )]


_nasm_object = rule(
    implementation = _impl,
    attrs = {
        "srcs" : attr.label_list(allow_files = True),
        "_nasm" : attr.label(
            default = Label("@nasm//:nasm"),
            allow_single_file = True,
            cfg = "host",
            executable = True,
        ),
        "extra_args" : attr.string_list(),
        "textual_hdrs" : attr.label_list(allow_files = True),
        "force_includes" : attr.label_list(allow_files = True),
        "includes" : attr.label_list(allow_files = True),
    },
)

def nasm_objects(name, srcs, **kwargs):
    _nasm_object(
        name = name,
        srcs = srcs,
        **kwargs)
