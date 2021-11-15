defmodule AuthPow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AuthPow.Repo,
      # Start the Telemetry supervisor
      AuthPowWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AuthPow.PubSub},
      # Start the Endpoint (http/https)
      AuthPowWeb.Endpoint
      # Start a worker by calling: AuthPow.Worker.start_link(arg)
      # {AuthPow.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuthPow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuthPowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
