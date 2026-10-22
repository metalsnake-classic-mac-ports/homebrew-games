class OuroScout < Formula
  desc "Faithful port of the 1993 Mac game S.C.Out by Kalisto"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "56c73734d986416f97ef6b60f31afd52a04d65704980bef3f27e3ec814028f98"
  license "MIT"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    sha256 cellar: :any, arm64_tahoe:   "0926b0c83c17ca1ebd85465656ab15f562ab61f4822f205cfee0ddfbd99a37f0"
    sha256 cellar: :any, arm64_sequoia: "4da67b91995b7acb5558bea9f05b089197f5ad3f3149132ae17800adee4842a1"
    sha256 cellar: :any, x86_64_linux:  "e62e5fc0713a33bbb04d6e533a7626f959ef9a0d8ed710dd804028ae07c2865b"
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
