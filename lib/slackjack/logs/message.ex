defmodule Slackjack.Logs.Message do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(id text)a
  @optional_fields ~w(channel_id user_id)a

  @primary_key {:id, :string, []}

  schema "messages" do
    field :text, :string
    belongs_to :channel, Slackjack.Logs.Channel, type: :string, on_replace: :update
    belongs_to :user, Slackjack.Logs.User, type: :string, on_replace: :update
    has_one :pin, Slackjack.Logs.Pin
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> put_change(:id, params.ts)
    |> put_change(:channel_id, params.channel)
    |> put_change(:user_id, params.user)
    |> foreign_key_constraint(:channel_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required(@required_fields)
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
  end

end
