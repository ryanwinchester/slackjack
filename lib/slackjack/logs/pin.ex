defmodule Slackjack.Logs.Pin do
  use Ecto.Schema

  schema "pins" do
    belongs_to :message, Slackjack.Logs.Message, type: :string
    belongs_to :channel, Slackjack.Logs.Channel, type: :string

    timestamps()
  end

end
