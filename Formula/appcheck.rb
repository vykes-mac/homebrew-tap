class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "53847215ad249145c20d58c82ca77c70bde8b609c07df44bea5313dd2c505510"

      def install
        bin.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "b77ac9e5e00b642bf2fe587991243d755f0c90a98230a0c919503753dd2ba070"

      def install
        bin.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]
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
