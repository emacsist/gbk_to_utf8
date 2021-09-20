defmodule GbkToUtf8.MixProject do
  use Mix.Project

  def project do
    [
      app: :gbk_to_utf8,
      version: "0.1.4",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
  """
  gbk 转换为 utf8
  """
end


  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:iconv, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:benchee, "~> 1.0", only: :dev}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
  [
   files: ["lib", "mix.exs", "README.md", "CP936.txt", "hello.gbk.txt"],
   maintainers: ["emacsist"],
   licenses: ["Apache 2.0"],
    links: %{"GitHub" => "https://github.com/emacsist/gbk_to_utf8",
            "Docs" => "https://hexdocs.pm/gbk_to_utf8/"}
   ]
end
end
