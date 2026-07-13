class Gt < Formula
  desc "Lazy git worktree"
  homepage "https://github.com/fkhadra/gt"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.0/gt-aarch64-apple-darwin.tar.xz"
      sha256 "d0df6135e538ef3c6b9bce2a9a8f8e1ee853d7c4a0d9bb9ef6c459c265664472"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.0/gt-x86_64-apple-darwin.tar.xz"
      sha256 "6dd5a4d6817e44a2560311ed4c5630bb8985feecc4a79ec526a3c87dc109b03d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.0/gt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9ad5d38e903fc7d79e58813ea067a79b268d06fada015ea5fc3b706fdc39975"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.0/gt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "64f8f4ca253984d89dba0aa1cc6074e69b4fcdccebf0adc0845637a76f1edffc"
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
    bin.install "gt" if OS.mac? && Hardware::CPU.arm?
    bin.install "gt" if OS.mac? && Hardware::CPU.intel?
    bin.install "gt" if OS.linux? && Hardware::CPU.arm?
    bin.install "gt" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
