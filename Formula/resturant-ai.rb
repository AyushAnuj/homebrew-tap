class ResturantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/resturant-ai"
  url "https://github.com/AyushAnuj/resturant-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8dc242b22a0519bb13681bf83e7de7b97a254f50261c3964f61ea02a75fa142b"
  license "MIT"

  depends_on "python@3.11"
  depends_on "ollama"

  def install
    virtualenv_create(libexec, "python3.11")

    system libexec/"bin/pip", "install", "."

    system libexec/"bin/pip", "install", "-r", "requirements.txt"

    bin.install_symlink libexec/"bin/resturant-ai"
  end

  def caveats
    <<~EOS
      Run:

        resturant-ai

      Make sure Ollama is running:

        ollama serve
    EOS
  end
end