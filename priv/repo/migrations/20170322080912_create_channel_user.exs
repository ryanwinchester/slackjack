defmodule Slackjack.Repo.Migrations.CreateChannelUser do
  use Ecto.Migration

  def change do
    create table(:channels_users) do
      add :channel_id, references(:channels, on_delete: :delete_all, type: :string)
      add :user_id, references(:users, on_delete: :delete_all, type: :string)
      timestamps()
    end

    create index(:channels_users, [:channel_id])
    create index(:channels_users, [:user_id])

  end
end
