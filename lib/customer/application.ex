defmodule Customer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Customer.Repo,
      # Start the Telemetry supervisor
      CustomerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Customer.PubSub},
      # Start the Endpoint (http/https)
      CustomerWeb.Endpoint
      # Start a worker by calling: Customer.Worker.start_link(arg)
      # {Customer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Customer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CustomerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
