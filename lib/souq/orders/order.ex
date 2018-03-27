defmodule Souq.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Souq.Orders.LineItem
  alias Souq.Payments.Payment

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "orders" do
    has_many(:line_items, LineItem)
    has_many(:payments, Payment)
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = order, attrs) do
    order
    |> cast(attrs, [])
    |> validate_required([])
  end
end
