class Appcheck < Formula
  desc "Local tooling to capture app walkthroughs and upload artifacts"
  homepage "https://github.com/vykes-mac/appcheck"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-arm64.tgz"
      sha256 "0aa95c527c8be5d12176cc107a40038aa10c6d299f33f9236a60a9b70711bf99"

      def install
        bin.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "e26d0bff355addb26be3c2345ab589450bc9ccffb6f28dd078e34bfcf2f2a77e"

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
