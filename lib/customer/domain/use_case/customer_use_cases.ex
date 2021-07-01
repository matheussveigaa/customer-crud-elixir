defmodule Customer.Domain.UseCase.CustomerUseCases do

  alias Customer.Domain.Repository.CustomerRepository
  alias Customer.Domain.Entities.Customer

  def list_customers() do
    case CustomerRepository.list_customers! do
      {:ok, customers} ->
        {:ok, customers}
      _ ->
        {:empty, []}
    end
  end

  def create(%Customer{} = customer) do
    case CustomerRepository.create! customer do
      {:ok, customer} ->
        {:ok, customer}
      {:error, error} ->
        {:error, error}
    end
  end

  def get_by_id(id) do
    case CustomerRepository.get_by_id! id do
      {:ok, customer} ->
        {:ok, customer}
      {:not_found, message} ->
        {:not_found, message}
    end
  end

  def update(%Customer{} = customer) do
    case CustomerRepository.update! customer do
      {:ok, customer} ->
        {:ok, customer}
      {:error, error} ->
        {:error, error}
      {:not_found, message} ->
        {:not_found, message}
    end
  end

  def delete(id) do
    case CustomerRepository.delete! id do
      {:ok} ->
        {:ok}
      {:error, error} ->
        {:error, error}
      {:not_found, message} ->
        {:not_found, message}
    end
  end
end
