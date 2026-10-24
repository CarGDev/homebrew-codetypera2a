class Codetypera2a < Formula
  desc "A2A hub, dispatcher and launcher for opencode v2 agents"
  homepage "https://github.com/CarGDev/codetyper.a2a"
  url "https://github.com/CarGDev/codetyper.a2a/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "80dacd67e3a1561501799f374b16b22955c4737dba9405910a79b6a7d2ccf6e2"
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
