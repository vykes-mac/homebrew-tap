class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "62f763715248fd38279c0446a20f83ad9fe334d57b5983fad79f4958caa45862"

      def install
        libexec.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]

        (bin/"appcheck").write <<~EOS
          #!/usr/bin/env bash
          set -euo pipefail

          export APPCHECK_UI_DIST_DIR="${APPCHECK_UI_DIST_DIR:-#{share}/appcheck/ui}"
          export APPCHECK_ENDPOINT_URL="${APPCHECK_ENDPOINT_URL:-https://peaceful-manatee-727.convex.site}"
          export APPCHECK_POSTHOG_KEY="${APPCHECK_POSTHOG_KEY:-phc_H70jM622HrQ5tkWMcPu30xGwPmdm4DO23zvuPyPZRAL}"
          export APPCHECK_POSTHOG_HOST="${APPCHECK_POSTHOG_HOST:-https://us.i.posthog.com}"

          exec "#{libexec}/appcheck" "$@"
        EOS
        chmod 0755, bin/"appcheck"
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "e0ec5cb775da9ad8d6639d12c117386a8372f493cd8a8b0b949b6b32914308c3"

      def install
        libexec.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]

        (bin/"appcheck").write <<~EOS
          #!/usr/bin/env bash
          set -euo pipefail

          export APPCHECK_UI_DIST_DIR="${APPCHECK_UI_DIST_DIR:-#{share}/appcheck/ui}"
          export APPCHECK_ENDPOINT_URL="${APPCHECK_ENDPOINT_URL:-https://peaceful-manatee-727.convex.site}"
          export APPCHECK_POSTHOG_KEY="${APPCHECK_POSTHOG_KEY:-phc_H70jM622HrQ5tkWMcPu30xGwPmdm4DO23zvuPyPZRAL}"
          export APPCHECK_POSTHOG_HOST="${APPCHECK_POSTHOG_HOST:-https://us.i.posthog.com}"

          exec "#{libexec}/appcheck" "$@"
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
