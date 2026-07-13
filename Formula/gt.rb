class Gt < Formula
  desc "Lazy git worktree"
  homepage "https://github.com/fkhadra/gt"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.1/gt-aarch64-apple-darwin.tar.xz"
      sha256 "0109e5cc951ca11b29c1ed26e3668581b23875e3601e790576c566e620244755"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.1/gt-x86_64-apple-darwin.tar.xz"
      sha256 "af5c8132995d587a1439adc38cdde8ca9dc1b74263dd8b6ec05881a294c5dc9a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.1/gt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5dc27f5b5bc2721c5ac72327c4602cf56ee016cc615a20767b6737122dbc3d2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.1/gt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7803b2bba4caf858adcb63397f6eb87de045c8f9f8d931164142d578f48333c1"
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
