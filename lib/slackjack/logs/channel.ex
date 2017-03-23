defmodule Slackjack.Logs.Channel do
  use Ecto.Schema

  @primary_key {:id, :string, []}

  schema "channels" do
    has_many :messages, Slackjack.Logs.Message
    has_many :pins, Slackjack.Logs.Pin

    timestamps()
  end

  def created(event) do
    # TODO
  end

  def archived(event) do
    # TODO
  end

end