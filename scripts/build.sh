#!/usr/bin/env bash
set -euo pipefail

# --- Define variables ---

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

TDLIB_REPO="https://github.com/tdlib/td.git"
TDLIB_COMMIT="8fc2344f3e3daf55983032a44c4156bd8a1a7533"

VENDOR="$ROOT/vendor"
DIST="$ROOT/dist"

# --- Clean the source tree and create folder ---

rm -rf "$VENDOR" "$DIST"
mkdir -p "$VENDOR" "$DIST"

# --- Clone the TDLib repo and apply the custom patch ---

git clone --revision "$TDLIB_COMMIT" --depth 1 --recursive "$TDLIB_REPO" "$VENDOR/td"

cd "$VENDOR/td"
git checkout "$TDLIB_COMMIT"
git submodule update --init --recursive

git apply "$ROOT/patches/tdlib-wasm.patch"

# --- Run the official scripts and copy the output ---

./example/web/build-openssl.sh
./example/web/build-tdlib.sh

cp "$VENDOR/td/example/web/build/wasm/td_wasm.js" "$DIST/"
cp "$VENDOR/td/example/web/build/wasm/td_wasm.wasm" "$DIST/"
cp "$VENDOR/td/example/web/build/wasm/td_wasm.d.ts" "$DIST/"
