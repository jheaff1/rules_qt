"""Run dependency workspace macros"""

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories")

def rules_qt_extra_extra_dependencies():
    # Note that node_repositories creates a nodejs_toolchains repo
    node_repositories(
        node_version = "18.5.0",
    )
