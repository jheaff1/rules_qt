"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//qt/private:versions.bzl", "QT_VERSIONS")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
def rules_qt_dependencies(qt_version):
    # The minimal version of bazel_skylib we require
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
    )

    qt_version_major, qt_version_minor, _ = qt_version.split(".")
    http_archive(
        name = "qt",
        build_file = "//:third_party/qt/BUILD.qt.bazel",
        sha256 = QT_VERSIONS[qt_version],
        strip_prefix = "qt-everywhere-src-{}".format(qt_version),
        url = "https://download.qt.io/official_releases/qt/{major}.{minor}/{full}/single/qt-everywhere-src-{full}.tar.xz".format(major = qt_version_major, minor = qt_version_minor, full = qt_version),
    )

#https://download.qt.io/official_releases/qt/6.2/6.2.2/single/qt-everywhere-src-6.2.2.zip
