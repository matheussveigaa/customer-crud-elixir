defmodule Customer.Application.Mappers.ResponseMapper do
  def to_error({ term, { message, validations } }) do
    %{
      field: term,
      message: message,
      validators: Enum.map(validations, fn {_type, validation} -> validation end)
    }
  end

  def to_errors(errors) do
    errorsFormated = Enum.map(errors, fn error -> to_error(error) end)

    %{errors: errorsFormated}
  end

  def as_customer_dto(%Customer.Infrastructure.Schemas.Customer{} = customer) do
    %{
      id: customer.id,
      name: customer.name,
      email: customer.email,
      taxId: customer.taxId,
      legalType: customer.legalType,
      inserted_at: customer.inserted_at,
      updated_at: customer.updated_at
    }
  end

  def as_customer_dto_list(customers) do
    customers
    |> Enum.map(fn customer -> as_customer_dto(customer) end)
  end
end
