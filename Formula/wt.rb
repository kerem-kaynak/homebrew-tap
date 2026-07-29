class Wt < Formula
  desc "Git worktrees that set themselves up. One shell function"
  homepage "https://github.com/kerem-kaynak/wt"
  url "https://github.com/kerem-kaynak/wt/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "14d1b8d181154008ada38293fd3092d26088c4e533b2175c88a7aae6bc06e98f"
  license "MIT"

  def install
    pkgshare.install "wt.sh", "examples", "skills"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      wt is a shell function (it has to cd your shell), so add this line to
      your ~/.zshrc or ~/.bashrc:

        source "#{opt_pkgshare}/wt.sh"

      Optional: let your coding agent write your repo's setup script —
        cp -r "#{opt_pkgshare}/skills/wt-setup-script" ~/.claude/skills/
    EOS
  end

  test do
    output = shell_output("bash -c 'source #{pkgshare}/wt.sh && wt --help' 2>&1", 1)
    assert_match "usage: wt", output
  end
end
