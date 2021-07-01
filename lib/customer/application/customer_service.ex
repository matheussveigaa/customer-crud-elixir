defmodule Customer.Application.CustomerService do
  import Customer.Application.Mappers.ResponseMapper

  alias Customer.Domain.UseCase.CustomerUseCases

  def list_customers() do
    case CustomerUseCases.list_customers do
      {:ok, customers} ->
        {:ok, as_customer_dto_list(customers)}
      {:empty, value} ->
        {:empty, value}
    end
  end

  def create(customer) do
    case CustomerUseCases.create customer do
      {:ok, customer} ->
        {:ok, as_customer_dto(customer)}
      {:error, error} ->
        {:error, to_errors(error.errors)}
    end
  end

  def get_by_id(id) do
    case CustomerUseCases.get_by_id id do
      {:ok, customer} ->
        {:ok, as_customer_dto(customer)}
      {:not_found, message} ->
        {:not_found, message}
    end
  end

  def update(customer) do
    case CustomerUseCases.update customer do
      {:ok, customer} ->
        {:ok, as_customer_dto(customer)}
      {:error, error} ->
        {:error, to_errors(error.errors)}
      {:not_found, message} ->
        {:not_found, %{message: message}}
    end
  end

  def delete(id) do
    case CustomerUseCases.delete id do
      {:ok} ->
        {:ok}
      {:error, error} ->
        {:error, to_errors(error.errors)}
      {:not_found, message} ->
        {:not_found, %{message: message}}
    end
  end
end
