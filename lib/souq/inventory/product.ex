defmodule Souq.Product do  
  @moduledoc """
  
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}  
  schema "products" do
    field(:name, :string)
  end

  def changeset(%__MODULE__{} = product, attrs) do
    product
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end