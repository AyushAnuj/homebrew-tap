class ResturantAi < Formula
  include Language::Python::Virtualenv

  desc "AI Restaurant Generator using Streamlit and Ollama"
  homepage "https://github.com/AyushAnuj/resturant-ai"
  url "https://github.com/AyushAnuj/resturant-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8dc242b22a0519bb13681bf83e7de7b97a254f50261c3964f61ea02a75fa142b"
  license "MIT"
  revision 7
  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3")

    # Install entire repository into a subdirectory under libexec to avoid
    # overwriting the virtualenv files
    (libexec/"app").install Dir["*"]

    # Read requirements from tap and install all dependencies
    tap_dir = Pathname.new(__FILE__).parent.parent
    requirements_file = tap_dir/"requirements.txt"
    
    # Copy requirements to libexec for pip install
    if requirements_file.exist?
      cp requirements_file, libexec/"requirements.txt"
      # Use system call to pip with -r flag for requirements file
      system "#{libexec}/bin/python", "-m", "pip", "install", "-r", "#{libexec}/requirements.txt"
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