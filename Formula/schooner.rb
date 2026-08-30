# typed: false
# frozen_string_literal: true

class Schooner < Formula
  desc "Operate persistent, user-owned development machines"
  homepage "https://github.com/thewelshrich/schooner"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.3.0/schooner_v0.3.0_darwin_arm64.tar.gz"
      sha256 "5c3a6403b0b0193875fc8bf7be897584e42bfd2518e4eeed4c6ed8ca278bdecc"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.3.0/schooner_v0.3.0_darwin_amd64.tar.gz"
      sha256 "a13b0788345a02eed138fff99f73b3c1e04f9f0c4cbd7f529aa94f13931049ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.3.0/schooner_v0.3.0_linux_arm64.tar.gz"
      sha256 "4745cb2e84c75a3b44271515e9801d1865572baec9995d2463f5f329b5467098"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.3.0/schooner_v0.3.0_linux_amd64.tar.gz"
      sha256 "b9d15b115e6c5ec02c98693695be8a18a807e48cb8e64367e122372dd8fb5fe6"
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
