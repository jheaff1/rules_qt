"""Run dependency workspace macros"""

load("@rules_qt_pip//:requirements.bzl", "install_deps")

def rules_qt_dependencies4():
    install_deps()

