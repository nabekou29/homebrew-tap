class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.10/trev-aarch64-apple-darwin.tar.xz"
      sha256 "f2bbc505ae7f22ca1129160e9bfce0c5c91e4ebe0b3b242cbd1d5d098ff5984b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.10/trev-x86_64-apple-darwin.tar.xz"
      sha256 "f07a58e6306d7f017b453e239952f49cad9f537c2803ad38380ea38457d9d0be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.10/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b60ce814369e51ac4ed707a7011c9c1204c0bd368b6e3e95c13fcad5738c0ea1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.10/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4fd907e5a7b2aac5cbebcee8f036c7bf4c716e7c6931a5bdacc405a617b5a305"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "trev" if OS.mac? && Hardware::CPU.arm?
    bin.install "trev" if OS.mac? && Hardware::CPU.intel?
    bin.install "trev" if OS.linux? && Hardware::CPU.arm?
    bin.install "trev" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
