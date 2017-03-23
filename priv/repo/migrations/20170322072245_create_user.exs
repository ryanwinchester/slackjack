defmodule Slackjack.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      add :real_name, :string
      add :status, :string
      add :color, :string
      add :deleted, :boolean
      add :id, :boolean
      add :is_admin, :boolean
      add :is_bot, :boolean
      add :is_owner, :boolean
      add :is_primary_owner, :boolean
      add :is_restricted, :boolean
      add :is_ultra_restricted, :boolean
      add :team_id, :string
      add :tz, :string
      add :tz_label, :string
      add :tz_offset, :integer
      add :profile, :jsonb

      timestamps()
    end
  end
end
