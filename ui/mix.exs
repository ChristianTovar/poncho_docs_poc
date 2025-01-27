defmodule Ui.MixProject do
  use Mix.Project

  def project do
    [
      app: :ui,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Ui.Application, []},
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
      {:phoenix, "~> 1.7.14"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      # TODO bump on release to {:phoenix_live_view, "~> 1.0.0"},
      {:phoenix_live_view, "~> 1.0.0-rc.1", override: true},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, "~> 1.5"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
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
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind ui", "esbuild ui"],
      "assets.deploy": [
        "tailwind ui --minify",
        "esbuild ui --minify",
        "phx.digest"
      ]
    ]
  end

  defp docs do
    [
      groups_for_modules: groups_for_modules(),
      source_url_pattern: source_url_pattern()
    ]
  end

  defp groups_for_modules do
    [
      Ui: [Mix.Tasks.PonchoDocs, Something, Something.Inside, Ui, Ui.Application],
      UiWeb: [
        UiWeb,
        UiWeb.CoreComponents,
        UiWeb.Endpoint,
        UiWeb.ErrorHTML,
        UiWeb.ErrorJSON,
        UiWeb.Layouts,
        UiWeb.PageController,
        UiWeb.PageHTML,
        UiWeb.Router,
        UiWeb.Telemetry
      ],
      One: [One, One.Application],
      Two: [Two, Two.Application]
    ]
  end

  def source_url, do: "https://github.com/ChristianTovar/poncho_docs_poc/tree/main"

  def source_url_pattern do
    fn path, line ->
      if String.contains?(path, "lib/temp/") do
        [[_, lib, path]] = Regex.scan(~r"lib/temp/([^/]*)/(.*)", path)
        "#{source_url()}/#{lib}/lib/#{path}#L#{line}"
      else
        "#{source_url()}/ui/#{path}#L#{line}"
      end
    end
  end
end
