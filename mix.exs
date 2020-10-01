defmodule Cox.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tbc,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      build_permanent: Mix.env == :prod,
      deps: [
        {:coxir, git: "https://github.com/satom99/coxir.git"},
        {:coxir_commander, git: "https://github.com/satom99/coxir_commander.git"},
        {:httpotion, "~> 3.1.0"},
        {:recon, "~> 2.3"}
      ]
    ]
  end

  def application do
    [
      mod: {Elosuite, []}
    ]
  end
end
