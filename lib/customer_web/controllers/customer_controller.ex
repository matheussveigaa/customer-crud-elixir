defmodule CustomerWeb.CustomerController do
  use CustomerWeb, :controller
  import Customer.Application.CustomerService

  alias Customer.Domain.Entities.Customer, as: Customer

  def index(conn, _params) do
    case list_customers() do
      {:ok, customers} -> json conn, customers
      _ -> json conn, []
    end
  end

  def create(conn, _params) do
    customerToCreate = %Customer{
      name: conn.body_params["name"],
      email: conn.body_params["email"],
      taxId: conn.body_params["taxId"],
      legalType: conn.body_params["legalType"]
    }

    case create customerToCreate do
      {:ok, customer} ->
        json conn, customer
      {:error, error} ->
        conn
        |> put_status(400)
        |> json(error)
    end
  end

  def show(conn, params) do
    %{"id" => id} = params
    case get_by_id id do
      {:ok, customer} ->
        json conn, customer
      {:not_found, message} ->
        conn
        |> put_status(404)
        |> json(%{message: message})
    end
  end

  def update(conn, params) do
    %{"id" => id} = params
    attr_update = %Customer{
      id: id,
      name: conn.body_params["name"],
      email: conn.body_params["email"],
      taxId: conn.body_params["taxId"],
      legalType: conn.body_params["legalType"]
    }

    case update attr_update do
      {:ok, customer} ->
        conn
        |> json(customer)
      {:not_found, message} ->
        conn
        |> put_status(404)
        |> json(message)
      {:error, error} ->
        conn
        |> put_status(400)
        |> json(error)
    end
  end

  def delete(conn, params) do
    %{"id" => id} = params

    case delete id do
      { :ok } ->
        conn
        |> json(%{message: "ok"})
      {:not_found, message} ->
        conn
        |> put_status(404)
        |> json(message)
      {:error, error} ->
        conn
        |> put_status(400)
        |> json(error)
    end
  end
end
