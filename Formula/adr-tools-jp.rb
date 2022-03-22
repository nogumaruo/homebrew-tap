class AdrToolsJp < Formula
  desc "CLI tool for working with Architecture Decision Records JP ver"
  homepage "https://github.com/nogumaruo/adr-tools-jp/"
  url "https://github.com/nogumaruo/adr-tools-jp/archive/3.0.1.tar.gz"
  sha256 "193474fa9bbfe9e7abce5f82abd1e040346814bbf34384ea7c4baad55ce9c656"
  license "CC-BY-4.0"

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