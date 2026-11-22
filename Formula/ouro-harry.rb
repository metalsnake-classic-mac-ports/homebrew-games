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
    manifest_sha256 "a7b854f58099f22b7c5edf3ccf0a7826f8d6dda7df08e2b1ec937ece2bd06e82"
    sha256 cellar: :any, arm64_tahoe:   "b7f5fe51ecea6671278f0e48ec085c9b90f733333de8de760478ffc54cf1fe0b"
    sha256 cellar: :any, arm64_sequoia: "4c5886e7b73ed902c6f090aa839e585301dc1a277005a0713de85c9054ddebe3"
    sha256 cellar: :any, arm64_linux:   "7d53f1d3e6c6321dd7a7f8eee4fb424cc9c85d03f3954d3f462b729fd4c3d1ba"
    sha256 cellar: :any, x86_64_linux:  "aa75ea937209f7cf94b29130bb11e35cce043473e9556f9d6f963dcc4767a17c"
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
