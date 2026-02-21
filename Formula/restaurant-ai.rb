class RestaurantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/restaurant-ai"

  url "https://github.com/AyushAnuj/restaurant-ai/archive/refs/tags/v1.0.0.tar.gz"

  sha256 "PASTE_SHA256_HERE"

  license "MIT"

  depends_on "python@3.11"
  depends_on "ollama"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Run the app with:

        restaurant-ai

      Make sure Ollama is running:

        ollama serve
    EOS
  end

end
