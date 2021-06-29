defmodule CustomerWeb.PageController do
  use CustomerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
