class Sdbh < Formula
  desc "Shell DB History: store and query shell command history in SQLite"
  homepage "https://github.com/mgd43b/shelldbhist"
  url "https://github.com/mgd43b/shelldbhist/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "1669536dca8615e45aabcc125dd35f17adbaff2eee026f1341e29f080a7b8d22"
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
