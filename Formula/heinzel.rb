class Heinzel < Formula
  desc "A terminal app for running a team of AI agents with their own terminals, skills and approvals."
  homepage "https://github.com/chustert/heinzel-releases"
  version "0.22.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.22.0/heinzel-aarch64-apple-darwin.tar.xz"
      sha256 "18fee99706281bfe525452b529a639563ede30c3a9bbc3db16ad4b5ded163d27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.22.0/heinzel-x86_64-apple-darwin.tar.xz"
      sha256 "4d25593a71de4b0892df327f8061333ecaf4cc0b75772ad04da55272a013ae38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.22.0/heinzel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c85990d3df33dd76932f6455e9cdd63487806a17d982613093dcebd606ee4fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.22.0/heinzel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9821e1d7edab03c5959d0d9c6f4c4ef7bf68d583875bc61eb597f417d5804835"
    end
  end

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
      bin.install "heinzel", "hzl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "heinzel", "hzl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "heinzel", "hzl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "heinzel", "hzl"
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
