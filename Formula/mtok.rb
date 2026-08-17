class Mtok < Formula
  desc "Terminal dashboard for AI token usage and spend from local Claude Code and Codex logs"
  homepage "https://github.com/kerem-kaynak/mtok"
  url "https://github.com/kerem-kaynak/mtok/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c4c344d9f5373e7fc85e72e0123fd7fd3ed181e21c96c6e386434403d08f62c7"
  license "MIT"
  head "https://github.com/kerem-kaynak/mtok.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/mtok"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtok --version")
  end
end
