load("@rules_java//java:defs.bzl", "java_binary", "java_test")
load(":scalac.bzl", "scalacs")

scalacs()

filegroup(
    name = "scalac_files",
    srcs = [
        "CompileOptions.java",
        "ProtoReporter.java",
        "ReportableMainClass.java",
        "ScalacWorker.java",
    ],
    visibility = ["//visibility:public"],
)

java_test(
    name = "CompileOptionsTest",
    srcs = ["CompileOptionsTest.java"],
    test_class = "io.bazel.rulesscala.scalac.CompileOptionsTest",
    deps = [":scalac_2.12"],
)
