defmodule Slackjack.Logs.User do
  use Ecto.Schema

  alias Slackjack.Repo

  @primary_key {:id, :string, []}

  schema "users" do
    field :email, :string
    field :name, :string
    field :deleted, :boolean
    field :is_admin, :boolean
    field :is_owner, :boolean
    field :is_primary_owner, :boolean
    field :is_restricted, :boolean
    field :is_ultra_restricted, :boolean

    many_to_many :channels, Slackjack.Logs.Channel, join_through: "channels_users"
    has_many :messages, Slackjack.Logs.Message

    timestamps()
  end

  def joined(event) do
    # TODO
  end

  def changed(event) do
    # TODO
  end

  @doc """
  Handles a user leaving a channel.

  ## Example ` event`

      {type: "message", subtype: "channel_leave", ts: "1358877455.000010",
       user: "U2147483828", text: "<@U2147483828|cal> has left the channel"}

  """
  def left_channel(event) do
    # TODO
  end
end
