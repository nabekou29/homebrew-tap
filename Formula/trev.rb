class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.11/trev-aarch64-apple-darwin.tar.xz"
      sha256 "99df0c2e7d12c4049bbe9881b847822e5b58a3ad377488ff9b9621a77e88655a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.11/trev-x86_64-apple-darwin.tar.xz"
      sha256 "97203b47a7e24c3488a5f287d9bba61b95a8cf959416649fed10d70570372641"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.11/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8beeb0498f3db76ddee080854ed2f9b759a37be6cfce8d1d5a4e1dae8d10f8ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.11/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6aa9e65cc4934521095f9f041b6239fbaedffeb7fba8ddf64cfab00b08912f07"
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
