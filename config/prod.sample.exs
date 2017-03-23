use Mix.Config

config :slackjack, Slackjack.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "slackjack_prod",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 20

config :slackjack, key: "slack_api_key"
