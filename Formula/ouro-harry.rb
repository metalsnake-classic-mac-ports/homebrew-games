class OuroHarry < Formula
  desc "Faithful port of the 1997 Mac game Harry the Handsome Executive"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-Harry-the-Handsome-Executive/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "38df72e3e73b3b73f45a3ae3627440e17e754393c1bcc8b600c51e5e89fb797b"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/metalsnake-classic-mac-ports/games"
    sha256 cellar: :any, arm64_tahoe:   "185de8c6be9c2eb76da8b32647af85d83b2d937a7e33b4fee5e1c49889bd1fe9"
    sha256 cellar: :any, arm64_sequoia: "6389845b3c10ca2de992f345093389f532f78c2857b77ee800d8715a30e8b2bf"
    sha256 cellar: :any, x86_64_linux:  "6c32989e57aa1a5bfdf79ca4ea71fde7266701aa32ef0e338fa5fbe43cf34ae1"
  end

  depends_on "rust" => :build
  depends_on "sdl3"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/harry")
  end

  test do
    assert_match "ouro-harry #{version}", shell_output("#{bin}/ouro-harry --version")
  end
end
