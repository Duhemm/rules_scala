load(
    "//scala/private/toolchain_deps:toolchain_deps.bzl",
    "expose_toolchain_deps",
)
load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")
load("@bazel_skylib//lib:partial.bzl", "partial")

# _toolchain_type = "@io_bazel_rules_scala//testing/toolchain:testing_toolchain_type"

def _toolchain_type(scala_version):
    return "@io_bazel_rules_scala//testing/toolchain:testing_toolchain_type_%s" % scala_version


def _testing_toolchain_deps(ctx):
    return expose_toolchain_deps(ctx, ctx.attr._toolchain_type)

def _make_testing_toolchain_deps(scala_version):
    toolchain_type = _toolchain_type(scala_version)
    # impl = partial.make(expose_toolchain_deps, toolchain_type_label=toolchain_type)
    return rule(
        implementation = _testing_toolchain_deps,
        attrs = {
            "deps_id": attr.string(mandatory = True),
            "_toolchain_type": attr.string(default=toolchain_type)
        },
        toolchains = [toolchain_type],
        incompatible_use_toolchain_transition = True,
    )

testing_toolchain_deps_212 = _make_testing_toolchain_deps("2.12")
testing_toolchain_deps_213 = _make_testing_toolchain_deps("2.13")

def make_toolchain_types():
    for scala_version in SCALA_MAJOR_VERSIONS:
        native.toolchain_type(
            name = "testing_toolchain_type_%s" % scala_version,
            visibility = ["//visibility:public"],
        )

def make_testing_toolchain_deps():
    for scala_version in SCALA_MAJOR_VERSIONS:
        fn = testing_toolchain_deps_213 if scala_version == "2.13" else testing_toolchain_deps_212
        fn(
            name = "junit_classpath_%s" % scala_version,
            deps_id = "junit_classpath_%s" % scala_version,
            visibility = ["//visibility:public"],
        )

        fn(
            name = "scalatest_classpath_%s" % scala_version,
            deps_id = "scalatest_classpath_%s" % scala_version,
            visibility = ["//visibility:public"],
        )

        fn(
            name = "specs2_classpath_%s" % scala_version,
            deps_id = "specs2_classpath_%s" % scala_version,
            visibility = ["//visibility:public"],
        )

        fn(
            name = "specs2_junit_classpath_%s" % scala_version,
            deps_id = "specs2_junit_classpath_%s" % scala_version,
            visibility = ["//visibility:public"],
        )

    native.alias(name="junit_classpath", actual=":junit_classpath_2.12", visibility=["//visibility:public"])
    native.alias(name="scalatest_classpath", actual=":scalatest_classpath_2.12", visibility=["//visibility:public"])
    native.alias(name="specs2_classpath", actual=":specs2_classpath_2.12", visibility=["//visibility:public"])
    native.alias(name="specs2_junit_classpath", actual=":specs2_junit_classpath_2.12", visibility=["//visibility:public"])
