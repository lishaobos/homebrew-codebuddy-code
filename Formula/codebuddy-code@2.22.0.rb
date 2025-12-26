class CodebuddyCodeAT2220 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.22.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "da3f9e6477695a9ab1c9d486ff898c68007997bc3ef630bcc3b82461f8750e69"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "31b16b53d10ae8c4db956693875f4eefee6f32d3634b2e16c31c4e7525a001e6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9c0a9e34633ec035831c87e4ed65b4b7515e37a59055ae5b984d484b24bf0d66"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "39c9443eb55717efbd14045211a931ec2762a4c22a3701f53b0334d86b9d2cd3"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "f4ed8ce4a16c7cb09d443d6dd8e3df3f1e777dd165b2b2d063e7b857c4925f55"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "c5d8fad63d503046278629bad3906610d7df4d2a2ff728a1954600992dc19d02"
      end
    end
  end

  def install
    bin.install "codebuddy"
    bin.install_symlink "codebuddy" => "cbc"
  end

  test do
    assert_predicate bin/"codebuddy", :exist?
    assert_predicate bin/"codebuddy", :executable?
    assert_predicate bin/"cbc", :exist?
    output = shell_output("#{bin}/codebuddy --version")
    assert_match version.to_s, output
  end
end
