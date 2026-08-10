class Pier < Formula
  desc "Give every agent session its own VM. One command up, zero burn when idle"
  homepage "https://github.com/kerem-kaynak/pier"
  url "https://github.com/kerem-kaynak/pier/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "75ceba0ba41ea3856f10e7e3574d6fd99fa5c933dccf6efc86a892a3fc548c92"
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
      pier drives your own AWS or GCP account through that cloud's CLI,
      which it needs on PATH:

        brew install awscli
        brew install --cask session-manager-plugin

      or:

        brew install --cask gcloud-cli

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
