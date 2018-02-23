defmodule Souq.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :username, :string

      timestamps()
    end

  end
end
