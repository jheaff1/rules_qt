""" This file lists supported Qt versions and their sha256 hashes """

# The integrity hashes can be computed with
QT_VERSIONS = {
    "6.2.4": "cfe41905b6bde3712c65b102ea3d46fc80a44c9d1487669f14e4a6ee82ebb8fd",
}

DEPS = {
    "python2-windows": {
        "url": "https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi",
        "sha256": "b74a3afa1e0bf2a6fc566a7b70d15c9bfabba3756fb077797d16fffa27800c05",
        "output": "python-2.7.18.amd64.msi",
    },
    "python2-src": {
        "url": "https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz",
        "sha256": "da3080e3b488f648a3d7a4560ddee895284c3380b11d6de75edb986526b9a814",
        "stripPrefix": "Python-2.7.18",
    },
}
