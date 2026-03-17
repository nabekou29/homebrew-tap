class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.1/trev-aarch64-apple-darwin.tar.xz"
      sha256 "0ed6d5fbf072aa0532c328adeb898505964a26d04e927326c32ad2a2be140748"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.1/trev-x86_64-apple-darwin.tar.xz"
      sha256 "da5bbb4b18ee6374bd395be0455b1ffedfb86f0de043c791d53d687fadc333ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.1/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "495792f6ac519f101616ecbf661462f7b57875609c418c2435c336ceb4db7e83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.1/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b72fac7d0fb09f807be9494a3350878443031bb2b0f3528e0aec0f6f9acbe532"
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
