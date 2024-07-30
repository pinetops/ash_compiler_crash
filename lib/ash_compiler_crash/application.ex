defmodule AshCompilerCrash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AshCompilerCrashWeb.Telemetry,
      AshCompilerCrash.Repo,
      {DNSCluster, query: Application.get_env(:ash_compiler_crash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AshCompilerCrash.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AshCompilerCrash.Finch},
      # Start a worker by calling: AshCompilerCrash.Worker.start_link(arg)
      # {AshCompilerCrash.Worker, arg},
      # Start to serve requests, typically the last entry
      AshCompilerCrashWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AshCompilerCrash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AshCompilerCrashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
