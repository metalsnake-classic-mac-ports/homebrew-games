class OuroHarry < Formula
  desc "Faithful port of the 1997 Mac game Harry the Handsome Executive"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-Harry-the-Handsome-Executive/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5f935f760c0fb3ed27eb25d1ce394fdf1ec92a85b7c855196c8c1d2b168da1e4"
  license "GPL-3.0-or-later"
  revision 1
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    sha256 cellar: :any, arm64_tahoe:   "bb02159ffd4c9b848d6dc0166be10fc98a14c0c463c7b7682c0bdea8580f2776"
    sha256 cellar: :any, arm64_sequoia: "c8e599bfbb31fdf41d0dc139d9693691e98948dc1eaabafbac28af6e22b2f1cc"
    sha256 cellar: :any, x86_64_linux:  "343199db84d888a0ba7119f53231db3e014b75738065610fc09932e692f2eff6"
  end

  depends_on "rust" => :build
  depends_on "sdl3"

  resource "ouro-framework" do
    url "https://github.com/metalsnake-classic-mac-ports/ouro-framework/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "2ce7698275996cf87c2ed6d52915764c09a7bf4ab1b4d4f2bb6bfe724b80f499"
  end

  def install
    # The port takes ouro-ui and ouro-play by path from ../ouro-framework;
    # here the framework sits inside the source tree.
    (buildpath/"ouro-framework").install resource("ouro-framework")
    inreplace "Cargo.toml", "../ouro-framework/", "ouro-framework/"
    system "cargo", "install", *std_cargo_args(path: "crates/harry")
  end

  test do
    assert_match "ouro-harry #{version}", shell_output("#{bin}/ouro-harry --version")
  end
end
