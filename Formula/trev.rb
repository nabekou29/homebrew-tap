class Trev < Formula
  desc "Fast TUI file viewer with tree view, syntax-highlighted preview, and Neovim integration"
  homepage "https://github.com/nabekou29/trev"
  version "0.1.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.13/trev-aarch64-apple-darwin.tar.xz"
      sha256 "36490c4c16a18ec7dce42efcec30dccf19158aea6d77b3f19e2e6a2df28fe164"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.13/trev-x86_64-apple-darwin.tar.xz"
      sha256 "22e553e97efebf4bdd7c1843323f0bd133004c98b4afee151e8657fe821ce9d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.13/trev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "85e3ff565e87c1a29ac5d37307600c0577342d2dd3f4ec24d747400ab9a94f0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nabekou29/trev/releases/download/v0.1.13/trev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19bb8e54f597dea87f7c00dea18d2d64f107dfc1301f30b9d1ffd7a427be78a2"
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
