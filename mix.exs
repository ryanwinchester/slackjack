defmodule Slackjack.Mixfile do
  use Mix.Project

  def project do
    [app: :slackjack,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Slackjack.Application, []}]
  end

  defp description do
    """
    Slack bot to log non-private team chat channels.
    """
  end

  defp package do
    [# These are the default files included in the package
     maintainers: ["Ryan Winchester"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ryanwinchester/slackjack"}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev},
     {:postgrex, ">= 0.0.0"},
     {:ecto, "~> 2.1"},
     {:poison, "~> 3.0"},
     {:distillery, "~> 1.0", runtime: false},
     {:slack, "~> 0.11.0"}]
  end
end
