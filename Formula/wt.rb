class Wt < Formula
  desc "Git worktrees that set themselves up. One shell function"
  homepage "https://github.com/kerem-kaynak/wt"
  url "https://github.com/kerem-kaynak/wt/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ebd7dfb647f6e438bdf0a5556f077803102547f28f3fe36932b1fcda46d8f23a"
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

      Optional environment variables, set next to that line:

        WT_ROOT   where worktrees live (default: ~/worktrees)
        WT_SETUP  setup script path, relative to each repo's root
                  (default: .wt-setup.sh)

      wt runs a repo's setup script in the background after creating a
      worktree: $WT_SETUP if it exists, else .wt-setup.sh at the repo root.
      Let your coding agent write it for you:

        cp -r "#{opt_pkgshare}/skills/wt-setup-script" ~/.claude/skills/

      then ask your agent to "set up wt for this repo".
    EOS
  end

  test do
    output = shell_output("bash -c 'source #{pkgshare}/wt.sh && wt --help' 2>&1", 1)
    assert_match "usage: wt", output
  end
end
