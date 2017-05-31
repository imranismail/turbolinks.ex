defmodule Turbolinks.Mixfile do
  use Mix.Project

  def project do
    [app: :turbolinks,
     version: "0.3.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    A plug and play package for using Turbolinks with Elixir web frameworks
    """
  end

  defp package do
    [name: :turbolinks,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Imran Ismail"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/imranismail/turbolinks"}]
  end

  defp deps do
    [{:phoenix, "~> 1.0 or ~> 1.2-rc"},
     {:plug, "~> 1.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
