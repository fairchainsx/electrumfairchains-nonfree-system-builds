#!/bin/bash
# Lucky number
export PYTHONHASHSEED=22

here=$(dirname "$0")
test -n "$here" -a -d "$here" || exit

echo "Clearing $here/build and $here/dist..."
rm "$here"/build/* -rf
rm "$here"/dist/* -rf

mkdir -p /tmp/electrumfairchains-build
mkdir -p /tmp/electrumfairchains-build/pip-cache
export PIP_CACHE_DIR="/tmp/electrumfairchains-build/pip-cache"

$here/build-secp256k1.sh || exit 1

$here/prepare-wine.sh || exit 1

echo "Resetting modification time in C:\Python..."
# (Because of some bugs in pyinstaller)
pushd /opt/wine64/drive_c/python*
find -exec touch -d '2000-11-11T11:11:11+00:00' {} +
popd
ls -l /opt/wine64/drive_c/python*

$here/build-electrumfairchains-git.sh && \
echo "Done."
