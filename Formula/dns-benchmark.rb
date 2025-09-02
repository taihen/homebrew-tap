class DnsBenchmark < Formula
  desc "DNS benchmark tool that tests DNS resolver performance across multiple protocols"
  homepage "https://github.com/taihen/dns-benchmark"
  url "https://github.com/taihen/dns-benchmark/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "6bfe71a8f7a87558f7f704145c36e3b3f3af980a13aad264584495185821b1fe"
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
