#!/bin/bash
set -euo pipefail

VERSION="${VERSION:?VERSION required}"
VERSION="${VERSION#v}"
FORMULA_PATH="Formula/appcheck.rb"

SHA256SUMS_URL="https://github.com/vykes-mac/appcheck-releases/releases/download/v${VERSION}/SHA256SUMS"
SHA256SUMS=$(curl -sL "$SHA256SUMS_URL")

ARM64_SHA256=$(echo "$SHA256SUMS" | grep "appcheck-darwin-arm64.tgz" | awk '{print $1}')
X64_SHA256=$(echo "$SHA256SUMS" | grep "appcheck-darwin-x64.tgz" | awk '{print $1}')

sed -i "s/version \".*\"/version \"${VERSION}\"/" "$FORMULA_PATH"

awk -v arm_sha="$ARM64_SHA256" -v x64_sha="$X64_SHA256" '
  /on_arm do/ { in_arm=1 }
  /on_intel do/ { in_arm=0; in_intel=1 }
  /sha256/ && in_arm { sub(/sha256 ".*"/, "sha256 \"" arm_sha "\""); in_arm=0 }
  /sha256/ && in_intel { sub(/sha256 ".*"/, "sha256 \"" x64_sha "\""); in_intel=0 }
  { print }
' "$FORMULA_PATH" > "${FORMULA_PATH}.tmp" && mv "${FORMULA_PATH}.tmp" "$FORMULA_PATH"
