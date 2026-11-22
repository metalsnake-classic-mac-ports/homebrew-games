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
    sha256 cellar: :any, arm64_tahoe:   "457349cb208d52875298cdb8a35c9f6d02b405e434234ea4bb893006e5e1408b"
    sha256 cellar: :any, arm64_sequoia: "4385c0bdfdf4ea16ccad9b7a4a319519f9a2e2320fb8ff7d611f522f61f65d04"
    sha256 cellar: :any, x86_64_linux:  "981c999078da36543f0296e5e2c8da5387a7f782a3839e031e905c0e7d058589"
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
