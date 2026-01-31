class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "ae049821e56610594f528a000e0b97e0e1a7eb90881ec3c48cac867510087290"

      def install
        bin.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "f2e49cf20e876e6099be08a6c138b7b034180f1ce44c1def8fc4c0eb2f47a0ef"

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
