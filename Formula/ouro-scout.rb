class OuroScout < Formula
  desc "Faithful port of the 1993 Mac game S.C.Out by Kalisto"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "6d05aeceb32861c0e983897d7081f8ee5717e48ce88a82bf762f22ce2a359faf"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-S.C.Out.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    manifest_sha256 "9ef76c497bd4fea0b541a4fcb4e59f7a69511652bcfb6a1219cd0829db9080b0"
    sha256 cellar: :any, arm64_tahoe:   "74bd95faeae444663bbd1b2857f2c8b1ae9a950c0ff8520b60c6005f9af44895"
    sha256 cellar: :any, arm64_sequoia: "b9c39d45b91ad4946ae9250ba14cd2c388c319008ee1c2bc4af80664fe52a18e"
    sha256 cellar: :any, arm64_linux:   "1e44dd9b423f19b76c786d921eb4d58da0c867f99d26e7b897f906957e71d090"
    sha256 cellar: :any, x86_64_linux:  "c4ddf8778b44ea239a9f8fef221d7e3ad0e8e3079c3bf774f8ae959eec5e9bf1"
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
