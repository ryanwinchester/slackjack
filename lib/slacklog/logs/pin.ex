defmodule Slacklog.Logs.Pin do
  use Ecto.Schema

  schema "pins" do
    belongs_to :message, Slacklog.Logs.Message, type: :string
    belongs_to :channel, Slacklog.Logs.Channel, type: :string
    
    timestamps()
  end
  
end