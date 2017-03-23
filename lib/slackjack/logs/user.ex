defmodule Slackjack.Logs.User do
  use Ecto.Schema

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
end
