class OuroScout < Formula
  desc "Faithful port of the 1993 Mac game S.C.Out by Kalisto"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dd23e8937b6ad6975b277eab8415df75860fbfd57272797bdb7804851181fe3b"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out.git", branch: "master"

  depends_on "rust" => :build
  depends_on "sdl3"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/scout")
  end

  test do
    assert_match "ouro-scout #{version}", shell_output("#{bin}/ouro-scout --version")
  end
end
