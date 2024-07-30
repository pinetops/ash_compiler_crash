defmodule Teamology.MixProject do
  use Mix.Project

  def project do
    [
      app: :teamology,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      consolidate_protocols: Mix.env() != :dev
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Teamology.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:ash, "~> 3.3.0"},
      {:phoenix, "~> 1.7.12"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0.0-rc.6", override: true},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, "~> 1.2"},
      {:langchain, git: "https://github.com/u2i/langchain.git"},
      {:ash_authentication, "~> 4.0.1"},
      {:ash_authentication_phoenix, "~> 2.0.0"},
      {:ash_postgres, "~> 2.1.17"},
      {:ash_phoenix, "~> 2.1.0"},
      {:tds, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:google_api_text_to_speech, "~> 0.17"},
      {:goth, "~> 1.4.3"},
      {:inflex, "~> 2.1.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:uuid, "~> 1.1"},
      {:adept_svg, "~> 0.3.1"},
      {:picosat_elixir, "~> 0.2.3"},
      {:recase, "~> 0.5"},
      {:oban, "~> 2.18"},
      {:ash_oban, "~> 0.2.3"},
      {:httpoison, "~> 2.2.1"},
      {:faker, "~> 0.18", only: :test},
      {:chromic_pdf, "~> 1.16.1"},
      {:ash_archival, github: "ash-project/ash_archival"},
      {:ash_state_machine, "~> 0.2.5"},
      {:mimic, "~> 1.9.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd --cd assets npm install"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind teamology", "esbuild teamology"],
      "assets.deploy": [
        "tailwind teamology --minify",
        "esbuild teamology --minify",
        "phx.digest"
      ]
    ]
  end
end
