defmodule Slackjack.Logs.Channel do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(id name name_normalized)a
  @optional_fields ~w()a

  @primary_key {:id, :string, []}

  schema "channels" do
    field :name, :string
    field :name_normalized, :string
    has_many :messages, Slackjack.Logs.Message
    has_many :pins, Slackjack.Logs.Pin
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> put_change(:id, params.id)
    |> validate_required(@required_fields)
  end

end
