class DnsBenchmark < Formula
  desc "DNS benchmark tool that tests DNS resolver performance across multiple protocols"
  homepage "https://github.com/taihen/dns-benchmark"
  url "https://github.com/taihen/dns-benchmark/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "8a0149e1ec1c890f7683b1332885ab060f6dcff96328ae0d4d7c2f0b4e65e611"
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
