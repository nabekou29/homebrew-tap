class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.12/trev-aarch64-apple-darwin.tar.xz"
      sha256 "af96b189ed641b71526e33f42f75c36a40e7ea763be10dcd6e73eeb8c60edb22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.12/trev-x86_64-apple-darwin.tar.xz"
      sha256 "9f8bfed5878b959656028a87be255e1432c5046eb661825298fb2787b6990392"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.12/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "83191ba31b553765bb778630f72df006d71ca212c00c7d87a7b41b1b89ea8e7d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.12/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a97f8102d444a30207b556a9061df4e2f45f1f18460fbd67d9e973841ec71062"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "trev"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "trev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "trev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "trev"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
