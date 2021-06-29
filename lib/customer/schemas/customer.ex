defmodule Customer.Schemas.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :email, :string
    field :legalType, :integer
    field :name, :string
    field :taxId, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :taxId, :legalType])
    |> validate_required([:name, :email, :taxId, :legalType])
  end
end
