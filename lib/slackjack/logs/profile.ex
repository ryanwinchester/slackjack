defmodule Slackjack.Logs.Profile do
  use Ecto.Schema

  import Ecto.Changeset
  
  @required_fields []
  @optional_fields ~w(first_name last_name real_name real_name_normalized
    title avatar_hash image_1024 image_192 image_24 image_32 image_48 image_512
    image_72 image_original)a

  embedded_schema do
    field :first_name, :string
    field :last_name, :string
    field :real_name, :string
    field :real_name_normalized, :string
    field :title, :string
    field :avatar_hash, :string
    field :image_1024, :string
    field :image_192, :string
    field :image_24, :string
    field :image_32, :string
    field :image_48, :string
    field :image_512, :string
    field :image_72, :string
    field :image_original, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end