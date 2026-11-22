class OuroScout < Formula
  desc "Faithful port of the 1993 Mac game S.C.Out by Kalisto"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "acfc3ddd237f76f26af159c7657585d5e08b808d83529de53b65c7e7fb0d5af6"
  license "GPL-3.0-or-later"
  revision 1
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    manifest_sha256 "871d86496f6c19f0ad3aef06cc66fd808166e12144e930844bc500556482d4c7"
    sha256 cellar: :any, arm64_tahoe:   "adb7ca17fae065fd0a0756d9b7b3de80dffa216d3c92267ee2190d74c97dc581"
    sha256 cellar: :any, arm64_sequoia: "5a3a6a83d376d538c9a037652e2cc7799487e256a1ab08dbce49fdf87a4d4a70"
    sha256 cellar: :any, arm64_linux:   "02a301b46a763d8fbb41182425648f9906b6f4391f4a61020020259fefd80e04"
    sha256 cellar: :any, x86_64_linux:  "fd8c57f7189f668d9460d179a20c7c70d863641ff898d62c9389d51afe427905"
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
    system "cargo", "install", *std_cargo_args(path: "crates/scout")
  end

  test do
    assert_match "ouro-scout #{version}", shell_output("#{bin}/ouro-scout --version")
  end
end
