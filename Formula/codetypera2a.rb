class Codetypera2a < Formula
  desc "A2A hub, dispatcher and launcher for opencode v2 agents"
  homepage "https://github.com/CarGDev/codetyper.a2a"
  url "https://github.com/CarGDev/codetyper.a2a/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "e4abbc5fd716e81000fd125d59e80561d2f154676de94abe62819c45ecf20c0e"
  license "MIT"
  head "https://github.com/CarGDev/codetyper.a2a.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    bin.install_symlink "codetypera2a" => "oc"
  end

  def caveats
    <<~CAVEATS
      Set up opencode (agents, commands, tabs plugin, MCP servers) once:
        codetypera2a init --shell
      then restart opencode. `oc status` shows whether the dispatcher is running.
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codetypera2a --version")
    assert_match "PASS routing", shell_output("#{bin}/codetypera2a eval routing")
    assert_match "oc trace", shell_output("#{bin}/oc help")
  end
end
