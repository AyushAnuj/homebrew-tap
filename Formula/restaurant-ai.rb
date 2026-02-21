class RestaurantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/resturant-ai"

  url "https://github.com/AyushAnuj/resturant-ai/archive/refs/tags/v1.0.0.tar.gz"

  sha256 "8dc242b22a0519bb13681bf83e7de7b97a254f50261c3964f61ea02a75fa142b"

  license "MIT"

  depends_on "python@3.11"
  depends_on "ollama"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Run the app with:

        resturant-ai

      Make sure Ollama is running:

        ollama serve
    EOS
  end

end
