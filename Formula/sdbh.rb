class Sdbh < Formula
  desc "Shell DB History: store and query shell command history in SQLite"
  homepage "https://github.com/mgd43b/shelldbhist"
  url "https://github.com/mgd43b/shelldbhist/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "7d086f94766b8de9f96b2a1308a9e0dbe863a8ab11ae5071f4eee07a674dda07"
  license "MIT"

  depends_on "rust" => :build

  def install
    # The Rust crate lives in ./sdbh within the repository.
    system "cargo", "install", "--locked", "--path", "sdbh", "--root", prefix
  end

  test do
    # Avoid touching the user's real history database.
    db = testpath/"test.sqlite"

    # Verify the binary runs and can create/open a database.
    system bin/"sdbh", "--db", db, "list", "--limit", "1"
  end
end
