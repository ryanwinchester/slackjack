defmodule Slacklog.Logs.Channel do
  use Ecto.Schema

  @primary_key {:id, :string, []}

  schema "channels" do
    has_many :messages, Slacklog.Logs.Message
    has_many :pins, Slacklog.Logs.Pin
    
    timestamps()
  end
  
end