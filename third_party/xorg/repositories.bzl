""" xorg repositories """
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# buildifier: disable=function-docstring
def xorg_repositories():
    maybe(
        http_archive,
        name = "libxcb",
        build_file = Label("//third_party/xorg:BUILD.libxcb.bazel"),
        sha256 = "cc38744f817cf6814c847e2df37fcb8997357d72fa4bcbc228ae0fe47219a059",
        strip_prefix = "libxcb-1.15",
        url = "https://xcb.freedesktop.org/dist/libxcb-1.15.tar.xz",
    )

    maybe(
        http_archive,
        name = "xcb-proto",
        build_file = Label("//third_party/xorg:BUILD.xcb-proto.bazel"),
        sha256 = "d34c3b264e8365d16fa9db49179cfa3e9952baaf9275badda0f413966b65955f",
        strip_prefix = "xcb-proto-1.15",
        url = "https://xcb.freedesktop.org/dist/xcb-proto-1.15.tar.xz",
    )

    maybe(
        http_archive,
        name = "libxshmfence",
        build_file = Label("//third_party/xorg:BUILD.libxshmfence.bazel"),
        sha256 = "7eb3d46ad91bab444f121d475b11b39273142d090f7e9ac43e6a87f4ff5f902c",
        strip_prefix = "libxshmfence-1.3",
        url = "https://www.x.org/releases/individual/lib/libxshmfence-1.3.tar.gz",
    )

    maybe(
        http_archive,
        name = "libxau",
        build_file = Label("//third_party/xorg:BUILD.libxau.bazel"),
        sha256 = "8be6f292334d2f87e5b919c001e149a9fdc27005d6b3e053862ac6ebbf1a0c0a",
        strip_prefix = "libXau-1.0.10",
        url = "https://www.x.org/pub/individual/lib/libXau-1.0.10.tar.xz",
    )

    maybe(
        http_archive,
        name = "xorgproto",
        build_file = Label("//third_party/xorg:BUILD.xorgproto.bazel"),
        sha256 = "5d13dbf2be08f95323985de53352c4f352713860457b95ccaf894a647ac06b9e",
        strip_prefix = "xorgproto-2022.2",
        url = "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2022.2.tar.xz",
    )

    maybe(
        http_archive,
        name = "libxdmcp",
        build_file = Label("//third_party/xorg:BUILD.libxdmcp.bazel"),
        sha256 = "2dce5cc317f8f0b484ec347d87d81d552cdbebb178bd13c5d8193b6b7cd6ad00",
        strip_prefix = "libXdmcp-1.1.4",
        url = "https://www.x.org/pub/individual/lib/libXdmcp-1.1.4.tar.xz",
    )

    maybe(
        http_archive,
        name = "libx11",
        build_file = Label("//third_party/xorg:BUILD.libx11.bazel"),
        sha256 = "081bf42ebab023aa92cfdb20c7af8c5ae13d13e88a5e22f90f4453ef80bbdde4",
        strip_prefix = "libX11-1.8",
        url = "https://www.x.org/archive/individual/lib/libX11-1.8.tar.xz",
    )

    maybe(
        http_archive,
        name = "libxrandr",
        build_file = Label("//third_party/xorg:BUILD.libxrandr.bazel"),
        sha256 = "897639014a78e1497704d669c5dd5682d721931a4452c89a7ba62676064eb428",
        strip_prefix = "libXrandr-1.5.3",
        url = "https://www.x.org/archive/individual/lib/libXrandr-1.5.3.tar.xz",
    )

    maybe(
        http_archive,
        name = "libxext",
        build_file = Label("//third_party/xorg:BUILD.libxext.bazel"),
        sha256 = "db14c0c895c57ea33a8559de8cb2b93dc76c42ea4a39e294d175938a133d7bca",
        strip_prefix = "libXext-1.3.5",
        url = "https://www.x.org/archive/individual/lib/libXext-1.3.5.tar.xz",
    )

    maybe(
        http_archive,
        name = "libxrender",
        build_file = Label("//third_party/xorg:BUILD.libxrender.bazel"),
        sha256 = "bc53759a3a83d1ff702fb59641b3d2f7c56e05051fa0cfa93501166fa782dc24",
        strip_prefix = "libXrender-0.9.11",
        url = "https://www.x.org/archive//individual/lib/libXrender-0.9.11.tar.xz",
    )

    maybe(
        http_archive,
        name = "renderproto",
        build_file = Label("//third_party/xorg:BUILD.renderproto.bazel"),
        sha256 = "a0a4be3cad9381ae28279ba5582e679491fc2bec9aab8a65993108bf8dbce5fe",
        strip_prefix = "renderproto-0.11.1",
        url = "https://www.x.org/releases/individual/proto/renderproto-0.11.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "xtrans",
        build_file = Label("//third_party/xorg:BUILD.xtrans.bazel"),
        sha256 = "48ed850ce772fef1b44ca23639b0a57e38884045ed2cbb18ab137ef33ec713f9",
        strip_prefix = "xtrans-1.4.0",
        url = "https://www.x.org/archive/individual/lib/xtrans-1.4.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "libpthread-stubs",
        build_file = Label("//third_party/xorg:BUILD.libpthread-stubs.bazel"),
        sha256 = "f8f7ca635fa54bcaef372fd5fd9028f394992a743d73453088fcadc1dbf3a704",
        strip_prefix = "libpthread-stubs-0.1",
        url = "https://www.x.org/archive//individual/lib/libpthread-stubs-0.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "libxfixes",
        build_file = Label("//third_party/xorg:BUILD.libxfixes.bazel"),
        sha256 = "82045da5625350838390c9440598b90d69c882c324ca92f73af9f0e992cb57c7",
        strip_prefix = "libXfixes-6.0.0",
        url = "https://www.x.org/archive//individual/lib/libXfixes-6.0.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "libXxf86vm",
        build_file = Label("//third_party/xorg:BUILD.libXxf86vm.bazel"),
        sha256 = "5108553c378a25688dcb57dca383664c36e293d60b1505815f67980ba9318a99",
        strip_prefix = "libXxf86vm-1.1.4",
        url = "https://www.x.org/releases/individual/lib/libXxf86vm-1.1.4.tar.gz",
    )
