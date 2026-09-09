# Homebrew formula for codeindex-sync.
#
# This is the SOURCE TEMPLATE. The live formula lives in the tap repo at
# github.com/mgd43b/homebrew-taps → Formula/codeindex-sync.rb.
#
# Do not edit `url`/`sha256` by hand — scripts/update-tap.sh resolves both from
# npm and writes the live formula. Publish to npm first; the formula installs
# the published tarball, so it cannot be generated before that.
#
# Users then install with:  brew install mgd43b/taps/codeindex-sync
class CodeindexSync < Formula
  desc "Git-hook-driven index sync for MCP code-search backends such as SocratiCode"
  homepage "https://github.com/mgd43b/codeindex-sync"
  url "https://registry.npmjs.org/codeindex-sync/-/codeindex-sync-0.1.2.tgz"
  sha256 "628ff045b652985bc842b3b565affe2a6a4e55395a990beadb58d6d1a89810c5"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/codeindex-sync/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codeindex-sync --version")

    # `providers --example` prints a config block; that it is valid JSON proves
    # the CLI runs and its presets survived packaging.
    require "json"
    example = shell_output("#{bin}/codeindex-sync providers --example")
    assert_kind_of Hash, JSON.parse(example)

    # An unknown command must fail rather than silently running the default.
    assert_match "unknown command", shell_output("#{bin}/codeindex-sync nope 2>&1", 1)
  end
end
