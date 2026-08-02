class Pier < Formula
  desc "Give every agent session its own VM. One command up, zero burn when idle"
  homepage "https://github.com/kerem-kaynak/pier"
  url "https://github.com/kerem-kaynak/pier/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "61cb4f137cdedab23adce51685c5ea13c21c2c8eaccd7129b64086961157a106"
  license "MIT"
  head "https://github.com/kerem-kaynak/pier.git", branch: "main"

  depends_on "go" => :build

  def install
    # make cross-compiles the in-VM supervisors and embeds them into the CLI
    system "make", "build"
    bin.install "pier"
    pkgshare.install "skills"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      pier drives your own AWS account through the aws CLI, which it needs
      on PATH along with the SSM Session Manager plugin:

        brew install awscli
        brew install --cask session-manager-plugin

      Then run once:

        pier setup

      The pier-onboard skill ships with the formula. To let your coding
      agent write your repo's pier files:

        cp -r "#{opt_pkgshare}/skills/pier-onboard" ~/.claude/skills/
    EOS
  end

  test do
    assert_match "pier", shell_output("#{bin}/pier help")
  end
end
