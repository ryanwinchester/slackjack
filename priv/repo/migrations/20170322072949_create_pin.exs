defmodule Slackjack.Repo.Migrations.CreatePin do
  use Ecto.Migration

  def change do
    create table(:pins) do
      add :channel_id, references(:channels, on_delete: :delete_all, type: :string)
      add :message_id, references(:messages, on_delete: :delete_all, type: :string)
      timestamps()
    end

    create index(:pins, [:channel_id])
    create index(:pins, [:message_id])

  end
end
