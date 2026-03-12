class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "2fadb3cb10281d63cd44c5eedd56990f841a87d074af632c96b14c9f44c53a34"

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
      sha256 "c29560c8b62f9c4b34041ad7ff14abfa0e1dc12722a9f626bbe65192d909c7ac"

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
