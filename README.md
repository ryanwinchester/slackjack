# Slackjack

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `slackjack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:slackjack, "~> 0.1.0"}]
end
```

    iex> {:ok, pid} = Slack.Bot.start_link(Slackjack.Bot, [], Application.get_env(:slackjack, :key))

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/slackjack](https://hexdocs.pm/slackjack).

