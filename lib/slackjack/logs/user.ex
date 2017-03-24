defmodule Slackjack.Logs.User do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(id name)a
  @optional_fields ~w(real_name status color deleted id is_admin is_bot is_owner
    is_primary_owner is_restricted is_ultra_restricted team_id tz tz_label tz_offset)a

  @primary_key {:id, :string, []}

  schema "users" do
    field :name, :string
    field :real_name, :string
    field :status, :string
    field :color, :string
    field :deleted, :boolean
    field :is_admin, :boolean
    field :is_bot, :boolean
    field :is_owner, :boolean
    field :is_primary_owner, :boolean
    field :is_restricted, :boolean
    field :is_ultra_restricted, :boolean
    field :team_id, :string
    field :tz, :string
    field :tz_label, :string
    field :tz_offset, :integer
    embeds_one :profile, Slackjack.Logs.Profile, on_replace: :update
    many_to_many :channels, Slackjack.Logs.Channel, join_through: "channels_users"
    has_many :messages, Slackjack.Logs.Message
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_embed(:profile)
    |> validate_required(@required_fields)
  end

end
