# typed: false
# frozen_string_literal: true

class Schooner < Formula
  desc "Operate persistent, user-owned development machines"
  homepage "https://github.com/thewelshrich/schooner"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.0/schooner_v0.4.0_darwin_arm64.tar.gz"
      sha256 "21720e4040cfd642671572315cb5fbda4733454cbb96e22032f8a8cad2cf0636"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.0/schooner_v0.4.0_darwin_amd64.tar.gz"
      sha256 "3bf9ab478a9710e03b240b17d9046b6e4cc2ebc2f5cf11eee020bed8dd402f1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.0/schooner_v0.4.0_linux_arm64.tar.gz"
      sha256 "ea877ea332356d257e40d50b0d097f2ca831f01fc8a62018175037865270946c"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.0/schooner_v0.4.0_linux_amd64.tar.gz"
      sha256 "b1899b97c5431223b35c2309429de9b3871ae55f98425aacafce6ed5626fe9f8"
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
