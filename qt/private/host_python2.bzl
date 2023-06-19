load(":versions.bzl", "DEPS")

def __host_python2_impl_windows(rctx):
    msiexec = rctx.which("msiexec.exe")
    if not msiexec:
        fail("Unable to find msiexec.exe")

    rctx.report_progress("Fetching python2 MSI")

    rctx.download(**DEPS["python2-windows"])

    msi_name = DEPS["python2-windows"]["output"]
    msi_path = str(rctx.path(msi_name)).replace("/", "\\")  # why is this necessary? (copied from rules 7zip)

    # msiexec seems to not like extracting to the current working directory, so extract to a folder named "python2"
    msi_target_dir = "python2"
    msi_target_path = str(rctx.path("python2")).replace("/", "\\")  # why is this necessary? (copied from rules 7zip)

    msi_extract_args = [
        msiexec,
        "/a",
        msi_path,
        "TARGETDIR=%s" % msi_target_path,
        "/qn",
    ]

    rctx.report_progress("Extracting %s" % msi_path)
    msi_extract_result = rctx.execute(msi_extract_args)

    if msi_extract_result.return_code != 0:
        err_message = msi_extract_result.stdout if msi_extract_result.stdout else msi_extract_result.stderr
        fail("Python2 MSI extraction failed: exit_code=%s\n\n%s" % (msi_extract_result.return_code, err_message))

    exec_python2_path = rctx.path("python2/python.exe")

    if not exec_python2_path.exists:
        fail("Missing %s after MSI extraction" % exec_python2_path)

    rctx.template(
        "BUILD",
        Label("//third_party/python2:BUILD.python2_windows.bazel.tpl"),
        {"%{target_dir}": msi_target_dir},
    )

def __host_python2_impl_linux(rctx):
    rctx.download_and_extract(**DEPS["python2-src"])
    rctx.file(
        "BUILD",
        rctx.read(Label("//third_party/python2:BUILD.python2_linux.bazel")),
    )

def _host_python2_impl(rctx):
    """ Implementation of the host_python2 repository rule."""

    if rctx.os.name.startswith("windows"):
        __host_python2_impl_windows(rctx)
    else:
        __host_python2_impl_linux(rctx)

host_python2 = repository_rule(
    implementation = _host_python2_impl,
    doc =
        """
        Download python2 msi file and extract it .TODO - some doc here. say why necessary, namely pip_install python_interpreter_target must be a file, not a build output
        """,
)
