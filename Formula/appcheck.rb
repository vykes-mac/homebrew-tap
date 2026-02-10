class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "359fa27908baf9ee416df99b95e550006c79f40842ea6da19b7afcf9f3878e52"

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
      sha256 "ac96ba37da6c0f76cca4a67ef96797f2da3e0f745e3d3efc056b9c59ac562ec7"

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
