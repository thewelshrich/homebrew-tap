# typed: false
# frozen_string_literal: true

class Schooner < Formula
  desc "Operate persistent, user-owned development machines"
  homepage "https://github.com/thewelshrich/schooner"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.2.0/schooner_v0.2.0_darwin_arm64.tar.gz"
      sha256 "22b78e058faa12c96a721ebc269da98e6c76ada0721531d12722ef3df4beb332"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.2.0/schooner_v0.2.0_darwin_amd64.tar.gz"
      sha256 "fe24a5930da925613882a58f75b744fbf0b68b29ba70421d497bde4a0e45796a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.2.0/schooner_v0.2.0_linux_arm64.tar.gz"
      sha256 "8d80ddb86f9767ef46ff68dcf51a0ad06caa6443b32659a08fbf053be019d5ce"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.2.0/schooner_v0.2.0_linux_amd64.tar.gz"
      sha256 "6c8ebea16336bea16f4e79215bdad961c2980d03f86fbdb1e57f60a1aed6c1ac"
    end
  end

  def install
    bin.install "schooner"
    generate_completions_from_executable(bin/"schooner", "completion")
  end

  test do
    require "json"

    document = JSON.parse(shell_output("#{bin}/schooner version --output json"))
    assert_equal "1", document.fetch("schema_version")
    assert_equal "v#{version}", document.fetch("version")
    assert_equal OS.mac? ? "darwin" : "linux", document.fetch("os")
    assert_equal Hardware::CPU.arm? ? "arm64" : "amd64", document.fetch("arch")
  end
end
