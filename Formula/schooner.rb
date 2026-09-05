# typed: false
# frozen_string_literal: true

class Schooner < Formula
  desc "Operate persistent, user-owned development machines"
  homepage "https://github.com/thewelshrich/schooner"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.1/schooner_v0.4.1_darwin_arm64.tar.gz"
      sha256 "4fcc55fcde002748c788f9660410fd80cfe9cac13856b6e3139bc3eb75042679"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.1/schooner_v0.4.1_darwin_amd64.tar.gz"
      sha256 "fc03fe3ee427df3e2ac32c8b173ba74f62845d1fa62bc9459e21b6bc6bf1e2d9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.1/schooner_v0.4.1_linux_arm64.tar.gz"
      sha256 "c40bbe5926d7565147e5b59ebdb16cde8f37ff46ee7a38b6379ad7cb56d1f53e"
    end
    on_intel do
      url "https://github.com/thewelshrich/schooner/releases/download/v0.4.1/schooner_v0.4.1_linux_amd64.tar.gz"
      sha256 "2faa9169b14dd36e30eb7febdce4bf4dd7f21a31c1312fbf08f11fd2adae3e0e"
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
