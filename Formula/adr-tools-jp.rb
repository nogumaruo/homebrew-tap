class AdrToolsJp < Formula
  desc "CLI tool for working with Architecture Decision Records JP ver"
  homepage "https://github.com/nogumaruo/adr-tools-jp/"
  url "https://github.com/nogumaruo/adr-tools-jp/archive/3.0.3.tar.gz"
  sha256 "f5cb44cbb9651036d81fd4a3c9900fbbb1292d3f78b734b373bcb366f04d37c1"
  license "CC-BY-4.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c90727c5bbac801707cfc081b3958f048b64e92f1157fae3079eb03834037a81"
  end

  def install
    config = buildpath/"src/adr-config"
    # Unlink and re-write to matches homebrew's installation conventions
    config.unlink
    config.write <<~EOS
      #!/bin/bash
      echo 'adr_bin_dir=\"#{bin}\"'
      echo 'adr_template_dir=\"#{prefix}\"'
    EOS

    prefix.install Dir["src/*.md"]
    bin.install Dir["src/*"]
    bash_completion.install "autocomplete/adr" => "adr-tools"
  end

  test do
    file = "001-record-architecture-decisions.md"
    assert_match file, shell_output("#{bin}/adr-init")
    assert_match file, shell_output("#{bin}/adr-list")
  end
end
