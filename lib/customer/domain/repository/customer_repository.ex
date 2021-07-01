defmodule Customer.Domain.Repository.CustomerRepository do
  alias Customer.Domain.Entities.Customer;

  @callback list_customers() :: {:ok,  [term]} | {:empty, []}
  @callback create(%Customer{}) :: {:ok, term} | {:error, term}
  @callback get_by_id(integer()) :: {:ok, term} | {:not_found, term}
  @callback update(%Customer{}) :: {:ok, term} | {:error, term} | {:not_found, term}
  @callback delete(integer()) :: {:ok} | {:error, term} | {:not_found, term}

  def list_customers!() do
    case impl().list_customers() do
      {:ok, customers} ->
        {:ok, customers}
      {:empty, customers} ->
        {:empty, customers}
      {:error, _} ->
        {:empty, []}
    end
  end

  def create!(%Customer{} = customer) do
    case impl().create(customer) do
      {:ok, customers} ->
        {:ok, customers}
      {:error, error} ->
        {:error, error}
    end
  end

  def get_by_id!(id) do
    case impl().get_by_id(id) do
      {:ok, customer} ->
        {:ok, customer}
      {:not_found, message} ->
        {:not_found, message}
    end
  end

  def update!(%Customer{} = customer) do
    case impl().update(customer) do
      {:ok, customers} ->
        {:ok, customers}
      {:not_found, message} ->
        {:not_found, message}
      {:error, error} ->
        {:error, error}
    end
  end

  def delete!(id) do
    case impl().delete(id) do
      {:ok} ->
        {:ok}
      {:not_found, message} ->
        {:not_found, message}
      {:error, error} ->
        {:error, error}
    end
  end

  defp impl() do
    Application.get_env(:customer, :customer_repository)
  end
end
