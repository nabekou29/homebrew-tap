class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.5/trev-aarch64-apple-darwin.tar.xz"
      sha256 "46f366173b38614ca75b67278b42d73ce99773dc077c65e6e1a6f863db323911"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.5/trev-x86_64-apple-darwin.tar.xz"
      sha256 "3d5727093a55bdea9ee3891af0e5d2c5feb716ce3e6821c8205c929fd6ccda78"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.5/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b5d16fc40b7c6f3a5cf99321275e81ada7866b2a47e1ee178ad221773e2a49df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.5/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7fcea4a0a8754f835354052f989f55c985fa8db3ee3e178bb65a043810dad4e"
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
