defmodule Slackjack.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :string, primary_key: true

      add :email, :string
      add :name, :string
      add :deleted, :boolean
      add :is_admin, :boolean
      add :is_owner, :boolean
      add :is_primary_owner, :boolean
      add :is_restricted, :boolean
      add :is_ultra_restricted, :boolean

      timestamps()
    end
  end
end
