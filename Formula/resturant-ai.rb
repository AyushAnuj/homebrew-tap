class ResturantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/resturant-ai"
  url "https://github.com/AyushAnuj/resturant-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8dc242b22a0519bb13681bf83e7de7b97a254f50261c3964f61ea02a75fa142b"
  license "MIT"

  depends_on "python@3.11"
  depends_on "ollama"

  resource "streamlit" do
    url "https://files.pythonhosted.org/packages/source/s/streamlit/streamlit-1.32.0.tar.gz"
    sha256 "replace_with_real_sha256"
  end

  resource "blinker" do
    url "https://files.pythonhosted.org/packages/source/b/blinker/blinker-1.7.0.tar.gz"
    sha256 "replace_with_real_sha256"
  end

  resource "langchain-core" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-core/langchain-core-0.1.0.tar.gz"
    sha256 "replace_with_real_sha256"
  end

  resource "langchain-community" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-community/langchain-community-0.0.20.tar.gz"
    sha256 "replace_with_real_sha256"
  end

  resource "langchain-ollama" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-ollama/langchain-ollama-0.1.0.tar.gz"
    sha256 "replace_with_real_sha256"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To run the app:

        resturant-ai

      Make sure Ollama server is running:

        ollama serve

      If llama3 is not installed:

        ollama pull llama3
    EOS
  end

  test do
    system "#{bin}/resturant-ai", "--help"
  end
end