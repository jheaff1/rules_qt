"""Run dependency workspace macros

A separate macro "rules_qt_extra_dependencies" is required as the "load" function can only be used at the top of a bzl file

"""

load("@rules_python//python:repositories.bzl", "python_register_toolchains")
load("@rules_perl//perl:deps.bzl", "perl_register_toolchains", "perl_rules_dependencies")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")

def rules_qt_dependencies2():
    python_register_toolchains(
        name = "python3_9",
        # Available versions are listed in @rules_python//python:versions.bzl.
        # We recommend using the same version your team is already standardized on.
        python_version = "3.9",
    )

    perl_rules_dependencies()
    perl_register_toolchains()

    rules_foreign_cc_dependencies()

    build_bazel_rules_nodejs_dependencies()
