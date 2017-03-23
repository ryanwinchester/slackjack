defmodule Slackjack.Logs.Message do
  use Ecto.Schema

  @primary_key {:id, :string, []}

  schema "messages" do
    field :text, :string

    belongs_to :channel, Slackjack.Logs.Channel, type: :string
    has_one :pin, Slackjack.Logs.Pin

    timestamps()
  end

end
