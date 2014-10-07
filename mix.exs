defmodule Hexoku.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexoku,
      version: "0.0.1",
      elixir: "~> 1.0.1",
      deps: deps,
      description: description,
      package: package,
      name: "Hexoku",
      source_url: "https://github.com/JonGretar/Hexoku",
      homepage_url: "http://jongretar.github.io/Hexoku"
    ]
  end

  def application do
    apps = [:logger, :httpoison]
    dev_apps = Mix.env == :dev && [:reprise] || []
    [applications: dev_apps ++ apps]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.5", only: :docs},
      {:earmark, ">= 0.0.0", only: :docs},
      {:reprise, "~> 0.3.0", only: :dev},
      {:jsex, "~> 2.0.0"},
      {:httpoison, "~> 0.4"}
    ]
  end

  defp description do
    """
    Heroku API client and Heroku Mix tasks for Elixir projects.
    """
  end

    defp package do
    [
      contributors: ["Jón Grétar Borgþórsson"],
      licenses: ["MIT"],
      links: %{
        "Documentation": "http://jongretar.github.io/Hexoku",
        "GitHub": "https://github.com/JonGretar/Hexoku",
        "Issues": "https://github.com/JonGretar/Hexoku/issues"
      }
    ]
  end
end
