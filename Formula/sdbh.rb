class Sdbh < Formula
  desc "Shell DB History: store and query shell command history in SQLite"
  homepage "https://github.com/mgd43b/shelldbhist"
  url "https://github.com/mgd43b/shelldbhist/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "81b68343c5484bf71e32ff61d483932f5c02796a087427d789bd0db6827bfcd8"
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
