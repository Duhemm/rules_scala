load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")
load(
    "@io_bazel_rules_scala//scala/private:rules/scala_library.bzl",
    "scala_library_2_12",
    "scala_library_2_13",
)

def _test_reporter_212():
    scala_library_2_12(
        name = "test_reporter_2.12",
        srcs = ["JUnitXmlReporter.scala"],
        scalacopts = [
            "-deprecation:true",
            "-encoding",
            "UTF-8",
            "-feature",
            "-language:existentials",
            "-language:higherKinds",
            "-language:implicitConversions",
            "-unchecked",
            "-Xfatal-warnings",
            "-Xlint",
            "-Yno-adapted-args",
            "-Ywarn-dead-code",
            "-Ywarn-numeric-widen",
            "-Ywarn-value-discard",
            "-Xfuture",
            "-Ywarn-unused-import",
            "-Ypartial-unification",
        ],
        visibility = ["//visibility:public"],
        deps = [
            "//scala/private/toolchain_deps:scala_xml_2.12",
            "//testing/toolchain:scalatest_classpath_2.12",
        ],
    )


def _test_reporter_213():
    scala_library_2_13(
        name = "test_reporter_2.13",
        srcs = ["JUnitXmlReporter.scala"],
        scalacopts = [
            "-deprecation:true",
            "-encoding",
            "UTF-8",
            "-feature",
            "-language:existentials",
            "-language:higherKinds",
            "-language:implicitConversions",
            "-unchecked",
            "-Xfatal-warnings",
            "-Xlint",
            "-Ywarn-dead-code",
            "-Ywarn-numeric-widen",
            "-Ywarn-value-discard",
            "-Wunused:imports",
        ],
        visibility = ["//visibility:public"],
        deps = [
            "//scala/private/toolchain_deps:scala_xml_2.13",
            "//testing/toolchain:scalatest_classpath_2.13",
        ],
    )


def test_reporter():
    if "2.12" in SCALA_MAJOR_VERSIONS:
        _test_reporter_212()

    if "2.13" in SCALA_MAJOR_VERSIONS:
        _test_reporter_213()
