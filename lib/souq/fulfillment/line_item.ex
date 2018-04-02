defmodule Souq.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Souq.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "line_items" do
    belongs_to(:order, Order)

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = line_item, attrs) do
    line_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
