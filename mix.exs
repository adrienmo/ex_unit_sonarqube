defmodule ExUnitSonarqube.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_unit_sonarqube,
      version: "0.1.1",
      name: "ExUnitSonarqube",
      description: "Generate a generic test execution file for SonarQube",
      source_url: "https://github.com/adrienmo/ex_unit_sonarqube",
      homepage_url: "https://github.com/adrienmo/ex_unit_sonarqube",
      package: package(),
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [extras: ["README.md"]]
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Adrien Moreau"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/adrienmo/ex_unit_sonarqube"}
    ]
  end
end
