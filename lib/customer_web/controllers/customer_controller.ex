defmodule CustomerWeb.CustomerController do
  use CustomerWeb, :controller

  alias Customer.Context
  alias Customer.Schemas.Customer

  def index(conn, _params) do
    json conn, Context.list_customers
  end

  def create(conn, _params) do
    case Context.create_customer %Customer{name: conn.body_params["name"]} do
      %{ name: name, id: id } -> json conn, %{"name" => name, "id" => id}
    end
  end

  def show(conn, params) do
    %{"id" => id} = params
    case Context.get_by_id id do
      %{ name: name, id: id } -> json conn, %{"name" => name, "id" => id}
      nil ->
        conn
        |> put_status(404)
        |> json(%{"error" => "Not found"})
    end
  end

  def update(conn, _params) do

    attr_update = %{"name" => conn.body_params["name"], "email" => conn.body_params["email"], "taxId" => conn.body_params["taxId"], "legalType" => conn.body_params["legalType"]}

    case Context.update_customer attr_update, conn.body_params["id"] do
      { :ok, %Customer{} = customer } ->
        conn
        |> json(%{"name" => customer.name, "id" => customer.id})
      nil ->
        conn
        |> put_status(404)
        |> json(%{"error" => "Not found"})
    end
  end

  def delete(conn, params) do
    %{"id" => id} = params

    case Context.delete_customer id do
      { :ok, %Customer{} = _customer } ->
        conn
        |> json(%{message: "ok"})
      nil ->
        conn
        |> put_status(404)
        |> json(%{"error" => "Not found"})
    end
  end
end
