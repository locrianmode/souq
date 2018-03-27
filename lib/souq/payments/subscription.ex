defmodule Souq.Payments.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "subscriptions" do
    field(:start_date, :utc_datetime)
    field(:end_date, :utc_datetime)
    field(:status, SubscriptionStatus)
    timestamps()
  end

  def changeset(%__MODULE__{} = subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
