class Heinzel < Formula
  desc "A terminal app for running a team of AI agents with their own terminals, skills and approvals."
  homepage "https://github.com/chustert/heinzel-releases"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.17.0/heinzel-aarch64-apple-darwin.tar.xz"
      sha256 "8d77f80c081c3650cdd2fd0bb951f2369d44fab305e6a81c3e99da4c73e68672"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.17.0/heinzel-x86_64-apple-darwin.tar.xz"
      sha256 "853f4bf4527658e55291e2e23ff6f3cd48d88d45204c7d9f582c9db252beeaf4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.17.0/heinzel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3373e3295ebaecdc03aef245a4fcc17cf3e416df44d3b867ffc56262089e9e38"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chustert/heinzel-releases/releases/download/v0.17.0/heinzel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c968a880561a93cd9dd1a9dbc01421254bb5943d09ab9831d0f58d97cfbd2808"
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
