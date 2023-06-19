"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//qt/private:versions.bzl", "QT_VERSIONS")
load("//qt/private:http_archive.bzl", custom_http_archive = "http_archive")
load("//qt/private:host_python2.bzl", "host_python2")
load("//third_party/autotools:repositories.bzl", "autotools_repositories")
load("//third_party/xorg:repositories.bzl", "xorg_repositories")

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
    maybe(
        http_archive,
        name = "qt",
        build_file = Label("//third_party/qt:BUILD.qt.bazel"),
        sha256 = QT_VERSIONS[qt_version],
        strip_prefix = "qt-everywhere-src-{}".format(qt_version),
        url = "https://download.qt.io/official_releases/qt/{major}.{minor}/{full}/single/qt-everywhere-src-{full}.tar.xz".format(major = qt_version_major, minor = qt_version_minor, full = qt_version),
    )

    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "a3a6e99f497be089f81ec082882e40246bfd435f52f4e82f37e89449b04573f6",
        strip_prefix = "rules_python-0.10.2",
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.10.2.tar.gz",
    )

    host_python2(name = "python2")

    maybe(
        http_archive,
        name = "rules_perl",
        sha256 = "5cefadbf2a49bf3421ede009f2c5a2c9836abae792620ed2ff99184133755325",
        strip_prefix = "rules_perl-0.1.0",
        urls = [
            "https://github.com/bazelbuild/rules_perl/archive/refs/tags/0.1.0.tar.gz",
        ],
    )

    # maybe(
    #     http_archive,
    #     name = "rules_foreign_cc",
    #     sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
    #     strip_prefix = "rules_foreign_cc-0.9.0",
    #     url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.9.0.tar.gz",
    # )

    maybe(
        http_archive,
        name = "rules_foreign_cc",
        sha256 = "0dd8a75428c52f4ed069c2aaec9b9666e5f6578e002d8ab85292cba3dc09a81f",
        strip_prefix = "rules_foreign_cc-add_meson_support_tidy",
        url = "https://github.com/jheaff1/rules_foreign_cc/archive/refs/heads/add_meson_support_tidy.zip",
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_nodejs",
        sha256 = "c78216f5be5d451a42275b0b7dc809fb9347e2b04a68f68bad620a2b01f5c774",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.5.2/rules_nodejs-5.5.2.tar.gz"],
    )

    maybe(
        http_archive,
        name = "vcpkg",
        build_file = Label("//third_party/vcpkg:BUILD.vcpkg.bazel"),
        sha256 = "099d473823bfa4c1b876ec5f99dc1f0d89da44f58557acff3eaee79335510086",
        strip_prefix = "vcpkg-2022.06.16.1",
        url = "https://github.com/microsoft/vcpkg/archive/refs/tags/2022.06.16.1.tar.gz",
    )

    maybe(
        custom_http_archive,
        name = "gperf",
        additional_files = {
            "@vcpkg//:ports/gperf/CMakeLists.txt": "ports/gperf",
            "@vcpkg//:ports/gperf/config.h.in": "ports/gperf",
        },
        build_file = Label("//third_party/gperf:BUILD.gperf.bazel"),
        # Patch injects files used by vcpkg to build gperf. The files are obtained from https://github.com/microsoft/vcpkg/tree/2022.06.16.1/ports/gperf
        # patches = ["//third_party/gperf:gperf.patch"],
        # According to http_archive documentation, any patch_args other than "-p" will force bazel to use command line tool "patch" rather than its java implementation.
        # As the java implementation does not support creating new files via a patch, add an arbitrary arg so that the command linen tool is used instead
        # patch_args = ["-s"],
        sha256 = "588546b945bba4b70b6a3a616e80b4ab466e3f33024a352fc2198112cdbb3ae2",
        strip_prefix = "gperf-3.1",
        url = "http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "bison",
        build_file = Label("//third_party/bison:BUILD.bison.bazel"),
        sha256 = "06c9e13bdf7eb24d4ceb6b59205a4f67c2c7e7213119644430fe82fbd14a0abb",
        strip_prefix = "bison-3.8.2",
        url = "https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz",
    )

    maybe(
        http_archive,
        name = "flex",
        build_file = Label("//third_party/flex:BUILD.flex.bazel"),
        sha256 = "e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995",
        strip_prefix = "flex-2.6.4",
        url = "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz",
    )

    maybe(
        http_archive,
        name = "openssl",
        build_file = Label("//third_party/openssl:BUILD.openssl.bazel"),
        sha256 = "9384a2b0570dd80358841464677115df785edb941c71211f75076d72fe6b438f",
        strip_prefix = "openssl-1.1.1o",
        urls = [
            "https://mirror.bazel.build/www.openssl.org/source/openssl-1.1.1o.tar.gz",
            "https://www.openssl.org/source/openssl-1.1.1o.tar.gz",
            "https://github.com/openssl/openssl/archive/OpenSSL_1_1_1o.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "zlib",
        build_file = Label("//third_party/zlib:BUILD.zlib.bazel"),
        sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        strip_prefix = "zlib-1.2.11",
        urls = [
            "https://zlib.net/zlib-1.2.11.tar.gz",
            "https://storage.googleapis.com/mirror.tensorflow.org/zlib.net/zlib-1.2.11.tar.gz",
        ],
    )

    # TODO build mesa with llvm-pipe
    maybe(
        http_archive,
        name = "mesa",
        build_file = Label("//third_party/mesa:BUILD.mesa.bazel"),
        patches = [
            # This patch is required for meson to find the hermetic python interpreter
            Label("//third_party/mesa:mesa.meson.build.patch"),
            # The following patches are required so that dependencies are hermetically tracked by meson
            Label("//third_party/mesa:mesa.src_loader_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_intel_vulkan_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_vulkan_util_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_gbm_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_gallium_frontends_dri_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_gallium_targets_dri_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_egl_meson.build.patch"),
            Label("//third_party/mesa:mesa.src_glx_meson.build.patch"),
            # This patch is required for mesa to build on MacOS
            Label("//third_party/mesa:mesa.src_gallium_frontends_dri_dri_util.c.patch"),
        ],
        sha256 = "670d8cbe8b72902a45ea2da68a9da4dc4a5d99c5953a926177adbce1b1640b76",
        strip_prefix = "mesa-22.1.4",
        url = "https://archive.mesa3d.org/mesa-22.1.4.tar.xz",
    )

    maybe(
        http_archive,
        name = "libdrm",
        build_file = Label("//third_party/libdrm:BUILD.libdrm.bazel"),
        sha256 = "00b07710bd09b35cd8d80eaf4f4497fe27f4becf467a9830f1f5e8324f8420ff",
        strip_prefix = "libdrm-2.4.112",
        url = "https://dri.freedesktop.org/libdrm/libdrm-2.4.112.tar.xz",
    )
    maybe(
        http_archive,
        name = "expat",
        build_file = Label("//third_party/expat:BUILD.expat.bazel"),
        sha256 = "a00ae8a6b96b63a3910ddc1100b1a7ef50dc26dceb65ced18ded31ab392f132b",
        strip_prefix = "expat-2.4.1",
        urls = [
            "https://mirror.bazel.build/github.com/libexpat/libexpat/releases/download/R_2_4_1/expat-2.4.1.tar.gz",
            "https://github.com/libexpat/libexpat/releases/download/R_2_4_1/expat-2.4.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "libpciaccess",
        build_file = Label("//third_party/libpciaccess:BUILD.libpciaccess.bazel"),
        sha256 = "84413553994aef0070cf420050aa5c0a51b1956b404920e21b81e96db6a61a27",
        strip_prefix = "libpciaccess-0.16",
        url = "https://www.x.org/archive//individual/lib/libpciaccess-0.16.tar.gz",
    )

    maybe(
        http_archive,
        name = "apr",
        build_file = Label("//third_party/apr:BUILD.apr.bazel"),
        patches = [
            # https://bz.apache.org/bugzilla/show_bug.cgi?id=50146
            Label("//third_party/apr:macos_iovec.patch"),
            # https://bz.apache.org/bugzilla/show_bug.cgi?id=64753
            Label("//third_party/apr:macos_pid_t.patch"),
            # https://apachelounge.com/viewtopic.php?t=8260
            Label("//third_party/apr:windows_winnt.patch"),
        ],
        sha256 = "48e9dbf45ae3fdc7b491259ffb6ccf7d63049ffacbc1c0977cced095e4c2d5a2",
        strip_prefix = "apr-1.7.0",
        urls = [
            "https://mirror.bazel.build/www-eu.apache.org/dist/apr/apr-1.7.0.tar.gz",
            "https://www-eu.apache.org/dist/apr/apr-1.7.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "llvm",
        build_file = Label("//third_party/llvm:BUILD.llvm.bazel"),
        sha256 = "8b3cfd7bc695bd6cea0f37f53f0981f34f87496e79e2529874fd03a2f9dd3a8a",
        strip_prefix = "llvm-project-14.0.6.src",
        url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.6/llvm-project-14.0.6.src.tar.xz",
    )

    maybe(
        http_archive,
        name = "libelf",
        build_file = Label("//third_party/libelf:BUILD.libelf.bazel"),
        sha256 = "591a9b4ec81c1f2042a97aa60564e0cb79d041c52faa7416acb38bc95bd2c76d",
        strip_prefix = "libelf-0.8.13",
        url = "https://fossies.org/linux/misc/old/libelf-0.8.13.tar.gz",
    )


    autotools_repositories()
    xorg_repositories()


