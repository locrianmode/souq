defmodule SouqWeb.PageController do
  use SouqWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
