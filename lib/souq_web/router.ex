defmodule SouqWeb.Router do
  use SouqWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SouqWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/tests", TestController)
    resources("/users", UserController)
  end

  scope "/api", SouqWeb do
    pipe_through(:api)

    resources("/users", UserController)
  end

  scope "/api/swagger" do
    forward("/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :souq, swagger_file: "swagger.json")
  end

  def swagger_info do
    version =
      case :application.get_key(:souq, :vsn) do
        {:ok, version} ->
          version

        :undefined ->
          Mix.Project.config()[:version]
      end

    %{
      info: %{
        version: "#{version}",
        title: "Souq"
      }
    }
  end
end
