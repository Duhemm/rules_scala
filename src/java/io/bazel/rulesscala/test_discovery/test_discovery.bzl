load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")
load("//scala/private:rules/scala_library.bzl", "scala_library_2_12", "scala_library_2_13")


def make_test_discovery():
    if "2.12" in SCALA_MAJOR_VERSIONS:
        _test_discovery_212()
    if "2.13" in SCALA_MAJOR_VERSIONS:
        _test_discovery_213()


def _test_discovery_212():
    scala_library_2_12(
        name = "test_discovery",
        srcs = [
            "DiscoveredTestSuite.scala",
            "FilteredRunnerBuilder.scala",
        ],
        visibility = ["//visibility:public"],
        deps = ["@io_bazel_rules_scala//testing/toolchain:junit_classpath_2.12"],
    )

def _test_discovery_213():
    scala_library_2_13(
        name = "test_discovery_2.13",
        srcs = [
            "DiscoveredTestSuite.scala",
            "FilteredRunnerBuilder.scala",
        ],
        visibility = ["//visibility:public"],
        deps = ["@io_bazel_rules_scala//testing/toolchain:junit_classpath_2.13"],
    )

# scala_library(
#     name = "test_discovery",
#     srcs = [
#         "DiscoveredTestSuite.scala",
#         "FilteredRunnerBuilder.scala",
#     ],
#     visibility = ["//visibility:public"],
#     deps = ["@io_bazel_rules_scala//testing/toolchain:junit_classpath"],
# )

