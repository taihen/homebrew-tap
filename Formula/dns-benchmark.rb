class DnsBenchmark < Formula
  desc "DNS benchmark tool that tests DNS resolver performance across multiple protocols"
  homepage "https://github.com/taihen/dns-benchmark"
  url "https://github.com/taihen/dns-benchmark/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "b887cb1a44a79a4c09ae2bde26fd1f55b391032181da7b2936a3073da444d460"
  license "MIT"
  head "https://github.com/taihen/dns-benchmark.git", branch: "main"

  depends_on "go" => :build

  def install
    # Set up Go environment
    ENV["CGO_ENABLED"] = "0"

    # Build the binary
    system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", "-o", "dns-benchmark", "./cmd"

    # Install the binary
    bin.install "dns-benchmark"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "dns-benchmark", shell_output("#{bin}/dns-benchmark --version")
  end
end
