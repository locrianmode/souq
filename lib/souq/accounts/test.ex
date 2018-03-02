defmodule Souq.Accounts.Test do
  use Ecto.Schema
  import Ecto.Changeset
  alias Souq.Accounts.Test

  schema "tests" do
    timestamps()
  end

  @doc false
  def changeset(%Test{} = test, attrs) do
    test
    |> cast(attrs, [])
    |> validate_required([])
  end
end
