class Heinzel < Formula
  desc "A terminal app for running a team of AI agents with their own terminals, skills and approvals."
  homepage "https://github.com/chustert/heinzel-releases"
  version "0.46.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.46.0/heinzel-aarch64-apple-darwin.tar.xz"
      sha256 "81e256647c2f27fe040177775c04d36f2a71fe08f7fd5686650ba37c7f9cdc1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.46.0/heinzel-x86_64-apple-darwin.tar.xz"
      sha256 "71ccc7a3709312e75199278cdd01b8e628b3493fee039e8bec07b9df059aae00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.46.0/heinzel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91d9a44e7a77ba82bcbc52e12f0f32827aa25307c17869ceea2528b5fd8d0138"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.46.0/heinzel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29ec3d8da5fd43cd77c926caecdb153ebd9fe13773c3b83ca82ec04265155a92"
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
