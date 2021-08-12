load("@io_bazel_rules_scala_config//:config.bzl", "SCALA_MAJOR_VERSIONS")

ScalacProvider = provider(
    doc = "ScalacProvider",
    fields = [
        "default_classpath",
        "default_macro_classpath",
        "default_repl_classpath",
    ],
)

DepsInfo = provider(
    doc = "Defines depset required by rules",
    fields = {
        "deps": "Deps",
        "deps_id": "Identifier by which rules access this depset",
    },
)

def _declare_deps_provider_impl(ctx):
    return [
        DepsInfo(
            deps = ctx.attr.deps,
            deps_id = ctx.attr.deps_id,
        ),
    ]

_declare_deps_provider = rule(
    implementation = _declare_deps_provider_impl,
    attrs = {
        "deps": attr.label_list(allow_files = True),
        "deps_id": attr.string(mandatory = True),
    },
)

def declare_deps_provider(**kwargs):
    name = kwargs["name"]
    deps_id = kwargs["deps_id"]
    visibility = kwargs["visibility"]
    deps = kwargs["deps"]
    for scala_major in SCALA_MAJOR_VERSIONS:
        new_deps_id = "%s_%s" % (deps_id, scala_major)
        new_name = "%s_%s" % (name, scala_major)
        new_deps = []
        for dep in deps:
            new_deps.append("%s_%s" % (dep, scala_major))

        _declare_deps_provider(
            name = new_name,
            deps_id = new_deps_id,
            visibility = visibility,
            deps = new_deps
        )
