#!/bin/bash
set -euo pipefail

VERSION="${VERSION:?VERSION required}"
VERSION="${VERSION#v}"
ENDPOINT_URL="${ENDPOINT_URL:?ENDPOINT_URL required}"
POSTHOG_HOST="${POSTHOG_HOST:?POSTHOG_HOST required}"
POSTHOG_KEY="${POSTHOG_KEY:?POSTHOG_KEY required}"
FORMULA_PATH="Formula/appcheck.rb"

SHA256SUMS_URL="https://github.com/vykes-mac/appcheck-releases/releases/download/v${VERSION}/SHA256SUMS"
SHA256SUMS=$(curl -sL "$SHA256SUMS_URL")

ARM64_SHA256=$(echo "$SHA256SUMS" | grep "appcheck-darwin-arm64.tgz" | awk '{print $1}')
X64_SHA256=$(echo "$SHA256SUMS" | grep "appcheck-darwin-x64.tgz" | awk '{print $1}')
test -n "$ARM64_SHA256" && test -n "$X64_SHA256"

cat > "$FORMULA_PATH" <<FORMULA
class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "${VERSION}"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "${ARM64_SHA256}"

      def install
        libexec.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]

        (bin/"appcheck").write <<~EOS
          #!/usr/bin/env bash
          set -euo pipefail

          export APPCHECK_UI_DIST_DIR="\${APPCHECK_UI_DIST_DIR:-#{share}/appcheck/ui}"
          export APPCHECK_ENDPOINT_URL="\${APPCHECK_ENDPOINT_URL:-${ENDPOINT_URL}}"
          export APPCHECK_POSTHOG_KEY="\${APPCHECK_POSTHOG_KEY:-${POSTHOG_KEY}}"
          export APPCHECK_POSTHOG_HOST="\${APPCHECK_POSTHOG_HOST:-${POSTHOG_HOST}}"

          exec "#{libexec}/appcheck" "\$@"
        EOS
        chmod 0755, bin/"appcheck"
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "${X64_SHA256}"

      def install
        libexec.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]

        (bin/"appcheck").write <<~EOS
          #!/usr/bin/env bash
          set -euo pipefail

          export APPCHECK_UI_DIST_DIR="\${APPCHECK_UI_DIST_DIR:-#{share}/appcheck/ui}"
          export APPCHECK_ENDPOINT_URL="\${APPCHECK_ENDPOINT_URL:-${ENDPOINT_URL}}"
          export APPCHECK_POSTHOG_KEY="\${APPCHECK_POSTHOG_KEY:-${POSTHOG_KEY}}"
          export APPCHECK_POSTHOG_HOST="\${APPCHECK_POSTHOG_HOST:-${POSTHOG_HOST}}"

          exec "#{libexec}/appcheck" "\$@"
        EOS
        chmod 0755, bin/"appcheck"
      end
    end
  end

  def caveats
    <<~EOS
      UI assets installed to: #{share}/appcheck/ui
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/appcheck --version")
  end
end
FORMULA
