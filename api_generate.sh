#!/usr/bin/env sh

git pull --ff-only
cd ApiParser && swift build -c release
cd ApiParser && curl https://raw.githubusercontent.com/tonlabs/TON-SDK/master/tools/api.json > api.json
cd ApiParser && ./.build/x86_64-apple-macosx/release/ApiParser ./api.json