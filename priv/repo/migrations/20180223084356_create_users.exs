defmodule Souq.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")

    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:username, :string)

      timestamps()
    end

    create(unique_index(:users, [:username]))
  end

  def down do
    drop(unique_index(:users, [:username]))
    drop(table(:users))
  end
end
