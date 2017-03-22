defmodule Slacklog.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      timestamps()
    end
  end
end
