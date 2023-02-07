# buildifier: disable=module-docstring
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# buildifier: disable=function-docstring
def autotools_repositories():
    maybe(
        http_archive,
        name = "m4",
        build_file = Label("//third_party/autotools:BUILD.m4.bazel"),
        strip_prefix = "m4-1.4.19",
        urls = [
            "https://mirror.bazel.build/ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz",
            "https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz",
        ],
        sha256 = "63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96",
    )
