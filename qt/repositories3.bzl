"""Run dependency workspace macros"""

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories")
load("@python3_9//:defs.bzl", py3_interpreter = "interpreter")
load("@rules_python//python:pip.bzl", "pip_parse")

def rules_qt_dependencies3():
    # Note that node_repositories creates a nodejs_toolchains repo
    node_repositories(
        node_version = "18.5.0",
    )

    pip_parse(
        name = "pip",
        python_interpreter_target = py3_interpreter,
        requirements_lock = "//:requirements_lock.txt",
    )
