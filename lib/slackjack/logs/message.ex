defmodule Slackjack.Logs.Message do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(text)a
  @optional_fields ~w(channel_id user_id)a

  @primary_key {:id, :string, []}

  schema "messages" do
    field :text, :string
    belongs_to :channel, Slackjack.Logs.Channel, type: :string
    belongs_to :user, Slackjack.Logs.User, type: :string
    has_one :pin, Slackjack.Logs.Pin
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(add_ids(params), @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  defp add_ids(params) do
    %{user_id: Map.get(params, :user),
      channel_id: Map.get(params, :channel)}
  end

end
