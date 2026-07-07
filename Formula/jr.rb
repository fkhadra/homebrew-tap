class Jr < Formula
  desc "Make my life easier with jira"
  homepage "https://github.com/fkhadra/jr"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/jr/releases/download/v0.1.0/jr-aarch64-apple-darwin.tar.xz"
      sha256 "f2300648e0d134516b147d5c3325216a72374354692ea75a90fa00572bf3e973"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/jr/releases/download/v0.1.0/jr-x86_64-apple-darwin.tar.xz"
      sha256 "48d4dc7361cdec406d519bef53963b50396036b59621a5ed6f129433d12c5f50"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fkhadra/jr/releases/download/v0.1.0/jr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c40164444c51972ef970235a5f761c776cc467704d3c6282a7f3e039d2556e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fkhadra/jr/releases/download/v0.1.0/jr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95a1eec03bef1af4e646f88d550a27eb9ccd48026148f8025f02f46f487ef699"
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
    bin.install "jr" if OS.mac? && Hardware::CPU.arm?
    bin.install "jr" if OS.mac? && Hardware::CPU.intel?
    bin.install "jr" if OS.linux? && Hardware::CPU.arm?
    bin.install "jr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
