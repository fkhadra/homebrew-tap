class Disco < Formula
  desc "Discover skills with ease"
  homepage "https://github.com/fkhadra/disco"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/disco/releases/download/v0.1.0/disco-aarch64-apple-darwin.tar.xz"
      sha256 "4a8fa9151b0e69f98beeda89834838e379a8dd707a0797ba45190b46931114a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/disco/releases/download/v0.1.0/disco-x86_64-apple-darwin.tar.xz"
      sha256 "b51ac40346da7889f118a1544faa0246215210adb074fce7539b47c58446dfcd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/disco/releases/download/v0.1.0/disco-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f782fd7d18886a25c2e3ab58e557af72ae4860b31d309f1ff91d0850a4f5f04f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/disco/releases/download/v0.1.0/disco-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "834b84ec8f352d676be4fdd5c274d4f81f3c4388a4c3e1fe4f6c7306d10b84ff"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
    bin.install "disco" if OS.mac? && Hardware::CPU.arm?
    bin.install "disco" if OS.mac? && Hardware::CPU.intel?
    bin.install "disco" if OS.linux? && Hardware::CPU.arm?
    bin.install "disco" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
