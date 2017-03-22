defmodule Slacklog.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :string, primary_key: true
      add :text, :string

      add :channel_id, references(:channels, on_delete: :delete_all, type: :string)
      add :user_id, references(:users, on_delete: :delete_all, type: :string)

      timestamps()
    end

    create index(:messages, [:channel_id])
    
  end
end
