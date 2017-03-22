defmodule Slacklog.Logs.Message do
  use Ecto.Schema

  @primary_key {:id, :string, []}

  schema "messages" do
    field :text, :string
    
    belongs_to :channel, Slacklog.Logs.Channel, type: :string
    has_one :pin, Slacklog.Logs.Pin

    timestamps()
  end
  
end