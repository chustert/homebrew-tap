class Heinzel < Formula
  desc "A terminal app for running a team of AI agents with their own terminals, skills and approvals."
  homepage "https://github.com/chustert/heinzel-releases"
  version "0.14.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.1/heinzel-aarch64-apple-darwin.tar.xz"
      sha256 "6fa5ea745c5932500d688299cca2a729bd7bbf6c2c3d027041be6b397337d351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.1/heinzel-x86_64-apple-darwin.tar.xz"
      sha256 "59ae7a7e7ae4f18a192f8b2e3e50c5336a01fff4e5879269aa1c1a8b4a9a8ed6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.1/heinzel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "264986c925319adede156a83bf3d70836bd448b8909fafb537524ec9fb91494c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.1/heinzel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "73240bc8589406e890f95bc9d5430170dc436ab4422204197b5712f06cd010fe"
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
