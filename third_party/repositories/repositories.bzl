load("//third_party/repositories:scala_2_11.bzl", _artifacts_2_11 = "artifacts")
load("//third_party/repositories:scala_2_12.bzl", _artifacts_2_12 = "artifacts")
load("//third_party/repositories:scala_2_13.bzl", _artifacts_2_13 = "artifacts")
load(
    "@io_bazel_rules_scala//scala:scala_cross_version.bzl",
    "default_maven_server_urls",
)
load(
    "@io_bazel_rules_scala//scala:scala_maven_import_external.bzl",
    _scala_maven_import_external = "scala_maven_import_external",
)
load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")

artifacts_by_major_scala_version = {
    "2.11": _artifacts_2_11,
    "2.12": _artifacts_2_12,
    "2.13": _artifacts_2_13,
}

def repositories(
        for_artifact_ids = [],
        maven_servers = default_maven_server_urls(),
        overriden_artifacts = {},
        fetch_sources = True):

    for major_scala_version in SCALA_MAJOR_VERSIONS:
        default_artifacts = artifacts_by_major_scala_version[major_scala_version]
        artifacts = dict(default_artifacts.items() + overriden_artifacts.items())
        for id in for_artifact_ids:
            cross_versioned_id = "%s_%s" % (id, major_scala_version)
            _scala_maven_import_external(
                name = cross_versioned_id,
                artifact = artifacts[cross_versioned_id]["artifact"],
                artifact_sha256 = artifacts[cross_versioned_id]["sha256"],
                licenses = ["notice"],
                server_urls = maven_servers,
                deps = artifacts[cross_versioned_id].get("deps", []),
                runtime_deps = artifacts[cross_versioned_id].get("runtime_deps", []),
                testonly_ = artifacts[cross_versioned_id].get("testonly", False),
                fetch_sources = fetch_sources,
            )
