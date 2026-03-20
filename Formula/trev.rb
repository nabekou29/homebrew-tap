class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.4/trev-aarch64-apple-darwin.tar.xz"
      sha256 "6f191c1100c0977d31f988894c2f58fb4f1169b5d9d8e9b8e39cc5a0c5f8859a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.4/trev-x86_64-apple-darwin.tar.xz"
      sha256 "308650d899c22897c5d3a3ff2b4e97e6753799dd8fbe8ce2297607f91fff0656"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.4/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7f8130c53a0d9c99f30a389f6b915f225776f7a81bf33971a13c9b94b369fd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.4/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf48fb5b43d98b3dba51bf46a2ebab725d8c55b5613a1e4c87f37149a0c38824"
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
