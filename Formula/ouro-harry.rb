class OuroHarry < Formula
  desc "Faithful port of the 1997 Mac game Harry the Handsome Executive"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-Harry-the-Handsome-Executive/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "043a5f918a883e112e0bbd92b537e3a4189ec435b89f37d90a2f508bbb00270f"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    manifest_sha256 "8b04be6010aecf9007e1cfba58a3e68168a82e9f080efd059a94a624444d943c"
    sha256 cellar: :any, arm64_tahoe:   "61e67453a1a5901da508c5847f17f67140208349b1d41ea102322c35c073fedc"
    sha256 cellar: :any, arm64_sequoia: "d93fc1b36b18b154c34228b1c808fba475e6725eb3d70b7aa6dd4bc174c89b2e"
    sha256 cellar: :any, arm64_linux:   "55b4e20d60b92d6e8e0317b7ec2de190996fee7837356f078dfc972a7f4a4b85"
    sha256 cellar: :any, x86_64_linux:  "eb52a94c53661f238a8775cc3ffc1218048aad6031d22e7ae4efa4b6e6e81da5"
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
