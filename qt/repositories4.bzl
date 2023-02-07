"""Run dependency workspace macros"""

load("@pip//:requirements.bzl", "install_deps")

def rules_qt_dependencies4():
    install_deps()

