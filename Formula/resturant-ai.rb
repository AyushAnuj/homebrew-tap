class ResturantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/resturant-ai"
  url "https://github.com/AyushAnuj/resturant-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8dc242b22a0519bb13681bf83e7de7b97a254f50261c3964f61ea02a75fa142b"
  license "MIT"
  revision 3
  depends_on "python@3.11"

  resource "streamlit" do
    url "https://files.pythonhosted.org/packages/source/s/streamlit/streamlit-1.54.0.tar.gz"
    sha256 "09965e6ae7eb0357091725de1ce2a3f7e4be155c2464c505c40a3da77ab69dd8"
  end

  resource "blinker" do
    url "https://files.pythonhosted.org/packages/source/b/blinker/blinker-1.9.0.tar.gz"
    sha256 "b4ce2265a7abece45e7cc896e98dbebe6cead56bcf805a3d23136d145f5445bf"
  end

  resource "langchain_core" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-core/langchain_core-1.2.14.tar.gz"
    sha256 "09549d838a2672781da3a9502f3b9c300863284b77b27e2a6dac4e6e650acfed"
  end

  resource "langchain_community" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-community/langchain_community-0.4.1.tar.gz"
    sha256 "f3b211832728ee89f169ddce8579b80a085222ddb4f4ed445a46e977d17b1e85"
  end

  resource "langchain_ollama" do
    url "https://files.pythonhosted.org/packages/source/l/langchain-ollama/langchain_ollama-1.0.1.tar.gz"
    sha256 "e37880c2f41cdb0895e863b1cfd0c2c840a117868b3f32e44fef42569e367443"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/source/r/requests/requests-2.32.5.tar.gz"
    sha256 "dbba0bac56e100853db0ea71b82b4dfd5fe2bf6d3754a8893c3af500cec7d7cf"
  end

  def install
    venv = virtualenv_create(libexec, "python3")

    # Install entire repository into a subdirectory under libexec to avoid
    # overwriting the virtualenv files
    (libexec/"app").install Dir["*"]

    # Explicitly fetch and pip-install each resource to ensure all are installed.
    # This bypasses potential Homebrew caching/skipping of resource installation.
    %w[streamlit blinker langchain_core langchain_community langchain_ollama requests].each do |rname|
      r = resource(rname)
      r.fetch
      venv.pip_install r.cached_download
    end

    (bin/"resturant-ai").write <<~EOS
      #!/bin/bash
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/python3" -m streamlit run "#{libexec}/app/resturant_ai/app.py" "$@"
    EOS
    (bin/"resturant-ai").chmod 0755
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