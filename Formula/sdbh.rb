class Sdbh < Formula
  desc "Shell DB History: store and query shell command history in SQLite"
  homepage "https://github.com/mgd43b/shelldbhist"
  url "https://github.com/mgd43b/shelldbhist/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "2164e3eddfd400cc7c7faa48d4285d3594f434ec3ed4e4017a09203d0cfa909b"
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
