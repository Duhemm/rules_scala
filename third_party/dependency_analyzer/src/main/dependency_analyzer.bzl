load("//scala:scala.bzl", "scala_library_for_plugin_bootstrapping")
load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")

def scala_versions():
    for scala_version in SCALA_MAJOR_VERSIONS:
        scala_library_for_plugin_bootstrapping(
            name = "scala_version_%s" % scala_version,
            srcs = [
                "io/bazel/rulesscala/dependencyanalyzer/ScalaVersion.scala",
            ],
            # As this contains macros we shouldn't make an ijar
            build_ijar = False,
            resources = ["resources/scalac-plugin.xml"],
            visibility = ["//visibility:public"],
            deps = [
                "//scala/private/toolchain_deps:scala_compile_classpath_%s" % scala_version,
            ],
        )

def dependency_analyzers():
    for scala_version in SCALA_MAJOR_VERSIONS:
        reporter_compatibility = "213" if scala_version == "2.13" else ""
        scala_library_for_plugin_bootstrapping(
            name = "dependency_analyzer_%s" % scala_version,
            srcs = [
                "io/bazel/rulesscala/dependencyanalyzer/AstUsedJarFinder.scala",
                "io/bazel/rulesscala/dependencyanalyzer/DependencyAnalyzer.scala",
                "io/bazel/rulesscala/dependencyanalyzer/DependencyAnalyzerSettings.scala",
                "io/bazel/rulesscala/dependencyanalyzer/HighLevelCrawlUsedJarFinder.scala",
                "io/bazel/rulesscala/dependencyanalyzer/OptionsParser.scala",
                "io/bazel/rulesscala/dependencyanalyzer/Reporter%s.scala" % reporter_compatibility,
            ],
            resources = ["resources/scalac-plugin.xml"],
            visibility = ["//visibility:public"],
            deps = [
                ":scala_version_%s" %scala_version,
                "//scala/private/toolchain_deps:scala_compile_classpath_%s" % scala_version,
            ],
        )
