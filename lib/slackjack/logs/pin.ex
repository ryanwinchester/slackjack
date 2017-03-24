defmodule Slackjack.Logs.Pin do
  use Ecto.Schema

  schema "pins" do
    belongs_to :message, Slackjack.Logs.Message, type: :string, on_replace: :update
    belongs_to :channel, Slackjack.Logs.Channel, type: :string, on_replace: :update

    timestamps()
  end

end
