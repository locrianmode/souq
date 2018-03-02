defmodule Souq.Payments.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field(:start_date, :datetime)
    field(:end_date, :datetime)
    field(:status, SubscriptionStatus)
    timestamps()
  end

  def changeset(%__MODULE__{} = subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
