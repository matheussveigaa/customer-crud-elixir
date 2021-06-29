defmodule Customer.Context do
  import Ecto.Query

  alias Customer.Schemas.Customer
  alias Customer.Repo

  def list_customers() do
    Repo.all(Customer)
    |> Enum.map(fn %{name: name, id: id} -> %{"name" => name, "id" => id} end)
  end

  def create_customer(%Customer{} = customer) do
    case Repo.insert customer do
      { :ok, customer } -> customer
    end
  end

  def get_by_id(id) do
    query = from(c in Customer, where: c.id == ^id)

    case Repo.one(query) do
      %Customer{} = customer -> customer
      nil -> nil
    end
  end

  def update_customer(customerUpdate, customerId) do
    case get_by_id customerId do
      %Customer{} = customer ->
        customer
        |> Customer.changeset(customerUpdate)
        |> Repo.update()
      nil -> nil
    end
  end

  def delete_customer(id) do
    case get_by_id(id) do
      %Customer{} = customer ->
        customer
        |> Repo.delete()
      nil -> nil
    end
  end
end
