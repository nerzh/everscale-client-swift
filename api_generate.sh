#!/usr/bin/env sh

git pull --ff-only
cd ApiParser
swift build -c release
curl https://raw.githubusercontent.com/everx-labs/ever-sdk/refs/heads/master/tools/api.json > api.json
if [ `uname -m` = arm64 ]; then
	./.build/arm64-apple-macosx/release/ApiParser ./api.json
else
	./.build/x86_64-apple-macosx/release/ApiParser ./api.json
fi
