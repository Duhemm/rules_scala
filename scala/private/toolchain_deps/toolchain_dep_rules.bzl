load(
    "//scala/private/toolchain_deps:toolchain_deps.bzl",
    "expose_toolchain_deps",
)
load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")

_toolchain_type = "@io_bazel_rules_scala//scala:toolchain_type"

def _common_toolchain_deps_impl(ctx):
    scala_version = ctx.attr._major_scala_version
    return expose_toolchain_deps(ctx, "%s_%s" % (_toolchain_type, scala_version))

# _common_toolchain_deps = rule(
#         implementation = _common_toolchain_deps_impl,
#         attrs = {
#             "deps_id": attr.string(mandatory = True),
#             "major_scala_version": attr.string(mandatory = True),
#         },
#         toolchains = ["%s_%s" % (_toolchain_type, scala_major)],
#         incompatible_use_toolchain_transition = True,
#     )

def make_common_toolchain_deps(scala_major):
    return rule(
        implementation = _common_toolchain_deps_impl,
        attrs = {
            "deps_id": attr.string(mandatory = True),
            "_major_scala_version": attr.string(
                default = scala_major,
            ),
        },
        toolchains = ["%s_%s" % (_toolchain_type, scala_major)],
        incompatible_use_toolchain_transition = True,
    )

make_212 = make_common_toolchain_deps("2.12")
make_213 = make_common_toolchain_deps("2.13")

def common_toolchain_deps(**kwargs):
    name = kwargs["name"]
    deps_id = kwargs["deps_id"]
    visibility = kwargs["visibility"]
    for scala_version in SCALA_MAJOR_VERSIONS:
        if scala_version == "2.12":
            make_212(
                name = "%s_%s" % (name, scala_version),
                deps_id = "%s_%s" % (name, scala_version),
                visibility = visibility
            )
        elif scala_version == "2.13":
            make_213(
                name = "%s_%s" % (name, scala_version),
                deps_id = "%s_%s" % (name, scala_version),
                visibility = visibility
            )
        else:
            fail("Unknown scala version: %s" % scala_version)
