class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "ce24fd2fae2dd388721ed1de4c454ef14d79e1b3a601287bbbb3bac6a582ecd9"

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
      sha256 "fd7a55d4d5a71e57ebd8023e151c32b5a269d4e3b5add7841a2d5b68c6ef7602"

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
