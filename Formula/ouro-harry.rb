class OuroHarry < Formula
  desc "Faithful port of the 1997 Mac game Harry the Handsome Executive"
  homepage "https://metalsnake-classic-mac-ports.github.io/Ouro-Harry-the-Handsome-Executive/"
  url "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "38df72e3e73b3b73f45a3ae3627440e17e754393c1bcc8b600c51e5e89fb797b"
  license "GPL-3.0-or-later"
  head "https://github.com/metalsnake-classic-mac-ports/Ouro-Harry-the-Handsome-Executive.git", branch: "main"

  depends_on "rust" => :build
  depends_on "sdl3"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/harry")
  end

  test do
    assert_match "ouro-harry #{version}", shell_output("#{bin}/ouro-harry --version")
  end
end
