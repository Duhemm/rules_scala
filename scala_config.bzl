load("//scala:scala_cross_version.bzl", "extract_major_version")

def _default_scala_version():
    """return the scala version for use in maven coordinates"""
    return "2.12.11"

def _store_config(repository_ctx):
    repository_ctx.file("BUILD", "exports_files(['config.bzl'])")

    scala_versions = repository_ctx.attr.scala_versions
    scala_major_versions = []
    for version in scala_versions:
        scala_major_versions.append(extract_major_version(version))

    config_file_content = []
    config_file_content.append("BAZEL_VERSION='%s'" % native.bazel_version)
    config_file_content.append("SCALA_MAJOR_VERSIONS=['%s']" % "', '".join(scala_major_versions))
    config_file_content.append("SCALA_VERSIONS=['%s']" % "', '".join(scala_versions))

    repository_ctx.file("config.bzl", "\n".join(config_file_content))


_config_repository = repository_rule(
    implementation = _store_config,
    attrs = {
        "scala_versions": attr.string_list(
            mandatory = True,
        ),
    },
)

def scala_config(scala_versions = [_default_scala_version()]):
    _config_repository(
        name = "io_bazel_rules_scala_config",
        scala_versions = scala_versions,
    )
