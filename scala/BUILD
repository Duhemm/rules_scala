load("@rules_java//java:defs.bzl", "java_import", "java_library")
load("//scala:scala_toolchain.bzl", "scala_toolchain")
load("//scala:providers.bzl", "declare_deps_provider")
load(":toolchains.bzl", "make_scala_toolchains", "make_toolchain_types")

make_toolchain_types()

make_scala_toolchains(
    scala_toolchain_name = "default_toolchain_impl",
    toolchain_name = "default_toolchain",
    scalacopts = [],
    dependency_mode = "direct",
    dependency_tracking_method = "default",
    strict_deps_mode = "default",
    unused_dependency_checker_mode = "off",
    visibility = ["//visibility:public"],
)

make_scala_toolchains(
    scala_toolchain_name = "unused_dependency_checker_error_toolchain_impl",
    toolchain_name = "unused_dependency_checker_error_toolchain",
    scalacopts = [],
    dependency_mode = "direct",
    dependency_tracking_method = "default",
    strict_deps_mode = "default",
    unused_dependency_checker_mode = "error",
    visibility = ["//visibility:public"],
)

make_scala_toolchains(
    scala_toolchain_name = "ast_plus_one_deps_strict_deps_unused_deps_error_impl",
    toolchain_name = "minimal_direct_source_deps",
    scalacopts = [],
    dependency_mode = "plus-one",
    dependency_tracking_method = "ast",
    strict_deps_mode = "error",
    unused_dependency_checker_mode = "error",
    visibility = ["//visibility:public"],
)

java_import(
    name = "bazel_test_runner_deploy",
    jars = ["@bazel_tools//tools/jdk:TestRunner_deploy.jar"],
    visibility = ["//visibility:public"],
)

java_library(
    name = "PlaceHolderClassToCreateEmptyJarForScalaImport",
    srcs = ["PlaceHolderClassToCreateEmptyJarForScalaImport.java"],
    visibility = ["//visibility:public"],
)

declare_deps_provider(
    name = "scala_compile_classpath_provider",
    deps_id = "scala_compile_classpath",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_scala_scala_compiler",
        "@io_bazel_rules_scala_scala_library",
        "@io_bazel_rules_scala_scala_reflect",
    ],
)

declare_deps_provider(
    name = "scala_library_classpath_provider",
    deps_id = "scala_library_classpath",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_scala_scala_library",
        "@io_bazel_rules_scala_scala_reflect",
    ],
)

declare_deps_provider(
    name = "scala_macro_classpath_provider",
    deps_id = "scala_macro_classpath",
    visibility = ["//visibility:public"],
    deps = [
        "@io_bazel_rules_scala_scala_library",
        "@io_bazel_rules_scala_scala_reflect",
    ],
)

declare_deps_provider(
    name = "scala_xml_provider",
    deps_id = "scala_xml",
    visibility = ["//visibility:public"],
    deps = ["@io_bazel_rules_scala_scala_xml"],
)

declare_deps_provider(
    name = "parser_combinators_provider",
    deps_id = "parser_combinators",
    visibility = ["//visibility:public"],
    deps = ["@io_bazel_rules_scala_scala_parser_combinators"],
)
