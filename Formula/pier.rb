class Pier < Formula
  desc "Give every agent session its own VM. One command up, zero burn when idle"
  homepage "https://github.com/kerem-kaynak/pier"
  url "https://github.com/kerem-kaynak/pier/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "20db5876d64b2db9fe8a9cf5866f2ae85abd18cb34f9686df11639ec3d5e2d5a"
  license "MIT"
  head "https://github.com/kerem-kaynak/pier.git", branch: "main"

  depends_on "go" => :build

  def install
    # make cross-compiles the in-VM supervisors and embeds them into the CLI;
    # the tarball has no .git, so the version is passed in
    system "make", "build", "VERSION=v#{version}"
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
    assert_match version.to_s, shell_output("#{bin}/pier version")
  end
end
