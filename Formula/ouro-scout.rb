class OuroScout < Formula
  desc "Faithful port of the 1993 Mac game S.C.Out by Kalisto"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dd23e8937b6ad6975b277eab8415df75860fbfd57272797bdb7804851181fe3b"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    sha256 cellar: :any, arm64_tahoe:   "edab85bd60270983fe9bda02a7cb50eb205bd3f1675a75bf47e6ed2cc3608250"
    sha256 cellar: :any, arm64_sequoia: "eeb902d6d23ab8e4ff1a5bac29f8044c27087fc91d4d9e9620f6aabd04d250b1"
    sha256 cellar: :any, x86_64_linux:  "b60633058f96c974af9cc8829df401d64e8055aae216095826c5a7ae2dc78cdd"
  end

  depends_on "rust" => :build
  depends_on "sdl3"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/scout")
  end

  test do
    assert_match "ouro-scout #{version}", shell_output("#{bin}/ouro-scout --version")
  end
end
