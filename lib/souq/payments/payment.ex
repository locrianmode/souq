defmodule Souq.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Souq.Orders.Order

  schema "payments" do
    belongs_to(:order, Order)

    timestamps()
  end
end