defmodule Apportion.Mixfile do
  use Mix.Project

  def project do
    [
      app: :apportion,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: "Elixir implementation for apportionment",
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.13", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:poison, "~> 2.2"}
    ]
  end

  defp package do
    [
      maintainers: ["Gary Fleshman"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/garyf/apportion_ex"}
    ]
  end
end
