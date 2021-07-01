defmodule Customer.Infrastructure.Persistence.Repository.CustomerRepositoryImpl do
  import Customer.Repo
  import Ecto.Query
  @behaviour Customer.Domain.Repository.CustomerRepository

  def list_customers() do
    costumers = all(Customer.Infrastructure.Schemas.Customer)

    case costumers do
       costumers when costumers != [] ->
        {:ok, costumers}
      _ ->
        {:empty, []}
    end
  end

  def create(%Customer.Domain.Entities.Customer{} = customer \\ %Customer.Domain.Entities.Customer{}) do
    changeset = Customer.Infrastructure.Schemas.Customer.changeset(%Customer.Infrastructure.Schemas.Customer{}, Map.from_struct(customer))

    case insert(changeset) do
      {:ok, customer} ->
        {:ok, customer}
      {:error, error} ->
        {:error, error}
    end
  end

  def get_by_id(id) do
    query = from(c in Customer.Infrastructure.Schemas.Customer, where: c.id == ^id)

    case one(query) do
      %Customer.Infrastructure.Schemas.Customer{} = customer -> {:ok, customer}
      _ -> {:not_found, "Not found"}
    end
  end

  def update(%Customer.Domain.Entities.Customer{} = customerUpdate \\ %Customer.Domain.Entities.Customer{}) do
    case get_by_id customerUpdate.id do
      {:ok, customer} ->
        customer
        |> Customer.Infrastructure.Schemas.Customer.changeset(Map.from_struct(customerUpdate))
        |> Customer.Repo.update()
      {:not_found, message} ->
        {:not_found, message}
    end
  end

  def delete(id) do
    case get_by_id id do
      {:ok, customer} ->
        customer
        |> Customer.Repo.delete
        {:ok}
      {:not_found, message} ->
        {:not_found, message}
    end
  end
end
