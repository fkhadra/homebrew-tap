class Gt < Formula
  desc "Lazy git worktree"
  homepage "https://github.com/fkhadra/gt"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.2/gt-aarch64-apple-darwin.tar.xz"
      sha256 "d7bbfab126c14c0e4bd831cecdfd063371c324aec62bbc670176ab6454b9b7c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.2/gt-x86_64-apple-darwin.tar.xz"
      sha256 "c68777114f6128b0f1c400a341cfef61b1276abc8f7f97e59789de85dadbe3f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.2/gt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74abe754592b270dd9435285b1b0878d11ac5220b2b6adab58168906bb57e411"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/gt/releases/download/v0.1.2/gt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "482813eda4405ba5a39fe8fa4b92cb439c5c6a9f7b656d74df500b427f45dbd8"
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
      bin.install "gt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gt"
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
