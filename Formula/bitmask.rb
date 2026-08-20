class Bitmask < Formula
  desc "Compute bitmask from specification"
  homepage "https://github.com/fkhadra/bitmask"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/bitmask/releases/download/v0.1.0/bitmask-aarch64-apple-darwin.tar.xz"
      sha256 "858cb5652bed186c1762e7f18bab0ca9afbfc1cf64dbff5d30e38c8497c11d11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/bitmask/releases/download/v0.1.0/bitmask-x86_64-apple-darwin.tar.xz"
      sha256 "7a70f3260dadf955c4095b919f6cab59abc1daab56c0289856d1f297f481f684"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/bitmask/releases/download/v0.1.0/bitmask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bae9f3bcbe063bbfd7dd79150f60ecc433b48f024564134b76d7a5af3d5098dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/bitmask/releases/download/v0.1.0/bitmask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a16248d8675e7965efb40fbe9625e062428fae3faa1721ccf46a6b784a806f3b"
    end
  end

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bitmask"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bitmask"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bitmask"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bitmask"
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
