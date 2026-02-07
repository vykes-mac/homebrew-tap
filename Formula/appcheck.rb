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
        bin.install "appcheck"
        (share/"appcheck/ui").install Dir["ui/*"]
      end
    end

    on_intel do
      url "https://github.com/vykes-mac/appcheck-releases/releases/download/v#{version}/appcheck-darwin-x64.tgz"
      sha256 "fd7a55d4d5a71e57ebd8023e151c32b5a269d4e3b5add7841a2d5b68c6ef7602"

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
