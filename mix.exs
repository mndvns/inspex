defmodule Inspex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inspex,
      version: "0.1.1",
      description: "simple Inspect protocol wrapper",
      consolidate_protocols: Mix.env != :test,
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Michael Vanasse"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/mndvns/inspex"},
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
