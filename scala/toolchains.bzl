load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")
load("@rules_java//java:defs.bzl", "java_import", "java_library")
load("//scala:scala_toolchain.bzl", "scala_toolchain")
load("//scala:providers.bzl", "declare_deps_provider")

def scala_register_toolchains():
    native.register_toolchains(
        "@io_bazel_rules_scala//scala:default_toolchain",
    )

def scala_register_unused_deps_toolchains():
    native.register_toolchains(
        "@io_bazel_rules_scala//scala:unused_dependency_checker_error_toolchain",
    )

def make_toolchain_types():
    for scala_version in SCALA_MAJOR_VERSIONS:
        native.toolchain_type(
            name = "toolchain_type_%s" % scala_version,
            visibility = ["//visibility:public"],
        )


def make_scala_toolchains(scala_toolchain_name, toolchain_name, scalacopts, dependency_mode, dependency_tracking_method, strict_deps_mode, unused_dependency_checker_mode, visibility):
    for scala_version in SCALA_MAJOR_VERSIONS:
        dep_providers = [
            "@io_bazel_rules_scala//scala:scala_xml_provider_%s" % scala_version,
            "@io_bazel_rules_scala//scala:parser_combinators_provider_%s" % scala_version,
            "@io_bazel_rules_scala//scala:scala_compile_classpath_provider_%s" % scala_version,
            "@io_bazel_rules_scala//scala:scala_library_classpath_provider_%s" % scala_version,
            "@io_bazel_rules_scala//scala:scala_macro_classpath_provider_%s" % scala_version,
        ]
        scala_toolchain(
            name = "%s_%s" % (scala_toolchain_name, scala_version),
            scalacopts = scalacopts,
            dependency_mode = dependency_mode,
            dependency_tracking_method = dependency_tracking_method,
            strict_deps_mode = strict_deps_mode,
            unused_dependency_checker_mode = unused_dependency_checker_mode,
            dep_providers = dep_providers,
            visibility = visibility
        )

        native.toolchain(
            name = "%s_%s" % (toolchain_name, scala_version),
            toolchain = ":%s_%s" % (scala_toolchain_name, scala_version),
            toolchain_type = "@io_bazel_rules_scala//scala:toolchain_type_%s" % scala_version,
            visibility = visibility
        )

