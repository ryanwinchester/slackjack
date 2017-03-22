use Mix.Config

config :slacklog, Slacklog.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "slacklog_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10
