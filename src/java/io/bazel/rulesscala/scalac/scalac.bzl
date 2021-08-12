load("@rules_java//java:defs.bzl", "java_binary")
load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")

def scalacs():
    for scala_version in SCALA_MAJOR_VERSIONS:
        java_binary(
            name = "scalac_%s" % scala_version,
            srcs = [
                ":scalac_files",
            ],
            javacopts = [
                "-source 1.8",
                "-target 1.8",
            ],
            main_class = "io.bazel.rulesscala.scalac.ScalacWorker",
            visibility = ["//visibility:public"],
            deps = [
                "//scala/private/toolchain_deps:scala_compile_classpath_%s" % scala_version,
                "//src/java/io/bazel/rulesscala/io_utils",
                "//third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
                "@io_bazel_rules_scala//src/java/io/bazel/rulesscala/jar",
                "@io_bazel_rules_scala//src/java/io/bazel/rulesscala/worker",
                "@io_bazel_rules_scala//src/protobuf/io/bazel/rules_scala:diagnostics_java_proto",
            ],
        )
