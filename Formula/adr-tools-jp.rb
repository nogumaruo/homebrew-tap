class AdrToolsJp < Formula
  desc "CLI tool for working with Architecture Decision Records JP ver"
  homepage "https://github.com/nogumaruo/adr-tools-jp/"
  url "https://github.com/nogumaruo/adr-tools-jp/archive/3.0.2.tar.gz"
  sha256 "bb8fb88edc0e12d3739aa1de5e38b719fdf9c633c301f7ac722a4e47be5044c5"
  license "CC-BY-4.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bb30126ed24957928cee4df9ef9c4768a928c07fbbf186075941901f16725ef1"
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
