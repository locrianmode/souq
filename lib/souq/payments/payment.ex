defmodule Souq.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Souq.Orders.Order

  schema "payments" do
    belongs_to(:order, Order)

    timestamps()
  end

  def changeset(%__MODULE__{} = payment, attrs) do
    payment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
