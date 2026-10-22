class Heinzel < Formula
  desc "A terminal app for running a team of AI agents with their own terminals, skills and approvals."
  homepage "https://github.com/chustert/heinzel-releases"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.0/heinzel-aarch64-apple-darwin.tar.xz"
      sha256 "ab13cabd75469aafa2285c6978066f18b5d60b0b970ed441c47b67dcd78bdafd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.0/heinzel-x86_64-apple-darwin.tar.xz"
      sha256 "7ceac80c95a81f7ee9490d2ae9cf1a327981bf1117c6039cf5a41a7d286b43f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.0/heinzel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "634ffb0c7c1a7b293b82951c39b3d089c2923550353413b060f5676b50b64c39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.14.0/heinzel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e9ca700a03d6ab53b5a8cd218884546ebf40c725f57297b86a27648dbb08f78"
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
