defmodule Slackjack.Logs.Message do
  use Ecto.Schema

  @primary_key {:id, :string, []}

  schema "messages" do
    field :text, :string

    belongs_to :channel, Slackjack.Logs.Channel, type: :string
    has_one :pin, Slackjack.Logs.Pin

    timestamps()
  end

  @doc """
  Handle the created message event.
  
  ### Example `event`

      {channel: "G4FL9V07P", source_team: "T4DA0KH89", team: "T4DA0KH89",
       text: "Yeah I took the intro to elixir last week", ts: "1490297265.925106",
       type: "message", user: "U4FLGAU4V"}

  """
  def created(event) do
    # TODO: stuff
  end

  @doc """
  Handle the message_changed event.
  
  ### Example `event`

      %{channel: "G4FL9V07P", event_ts: "1490297765.107605", hidden: true,
        message: %{edited: %{ts: "1490297765.000000", user: "U4E358LCV"},
        text: "testing 123 123", ts: "1490297756.104239", type: "message",
        user: "U4E358LCV"},
        previous_message: %{text: "testing 123", ts: "1490297756.104239",
        type: "message", user: "U4E358LCV"}, subtype: "message_changed",
        ts: "1490297765.107605", type: "message"}
        
  """
  def changed(event) do
    # TODO: stuff
  end

  @doc """
  Handle the message_deleted event.
  
  ### Example `event`

      %{channel: "G4FL9V07P", deleted_ts: "1490297842.135114",
        event_ts: "1490297846.136795", hidden: true,
        previous_message: %{text: "test delete", ts: "1490297842.135114",
        type: "message", user: "U4E358LCV"}, subtype: "message_deleted",
        ts: "1490297846.136795", type: "message"}

  """
  def deleted(event) do
    # TODO
  end

end
