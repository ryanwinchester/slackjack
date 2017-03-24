defmodule Slackjack.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @slack_token Application.get_env(:slack, :api_token)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Slackjack.Worker.start_link(arg1, arg2, arg3)
      # worker(Slackjack.Worker, [arg1, arg2, arg3]),
      supervisor(Slackjack.Repo, []),
      worker(Slack.Bot, [Slackjack.Bot, [], @slack_token], restart: :permanent),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Slackjack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
