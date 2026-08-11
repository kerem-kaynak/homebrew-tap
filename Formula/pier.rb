class Pier < Formula
  desc "Give every agent session its own VM. One command up, zero burn when idle"
  homepage "https://github.com/usepier/pier"
  url "https://github.com/usepier/pier/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "3fde12d112a45e402f8537492018a385211d9281ea08a2e85779512fb2d04a9f"
  license "MIT"
  head "https://github.com/usepier/pier.git", branch: "main"

  # pier moved to the usepier org; this copy tracks it one last time so
  # existing installs upgrade cleanly, then nudges everyone to the new tap
  deprecate! date: "2026-08-11", because: "has moved to usepier/tap/pier — run `brew untap kerem-kaynak/tap && brew install usepier/tap/pier` (keep the tap and just reinstall pier if you also use wt)"

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
