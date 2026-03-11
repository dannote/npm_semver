defmodule NPMSemver.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/dannote/npm_semver"

  def project do
    [
      app: :npm_semver,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "NPMSemver",
      description:
        "npm-compatible semantic versioning — parse, match, and compare versions using npm range syntax (^, ~, x-ranges, hyphen ranges, ||).",
      source_url: @source_url,
      homepage_url: @source_url,
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp deps do
    [
      {:nimble_parsec, "~> 1.0"},
      {:hex_solver, "~> 0.2"},
      {:ex_doc, "~> 0.35", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w[lib mix.exs README.md LICENSE CHANGELOG.md]
    ]
  end

  defp docs do
    [
      main: "NPMSemver",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}"
    ]
  end
end
