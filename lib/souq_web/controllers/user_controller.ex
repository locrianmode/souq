defmodule SouqWeb.UserController do
  use SouqWeb, :controller
  use PhoenixSwagger

  alias Souq.Accounts
  alias Souq.Accounts.User

  action_fallback(SouqWeb.FallbackController)

  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("")

          properties do
            username(:string)
            name(:string)
          end

          example(%{
            user: %{
              username: "joe.chang",
              name: "Joe Chang"
            }
          })
        end,
      Users:
        swagger_schema do
          title("Users")
          description("")
          type(:array)
          items(Schema.ref(:User))
        end
    }
  end

  swagger_path :index do
    get("/api/users")
    description("")
    response(200, "Success", Schema.ref(:Users))
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @json %{private: %{phoenix_format: "json"}}
  @html %{private: %{phoenix_format: "html"}}

  swagger_path :create do
    post("/api/users")
    description("")
    parameter(:data, :body, Schema.ref(:User), "")
    response(201, "Success")
    response(422, "")
  end

  def create(@json = conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def create(@html = conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(@json = conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def update(@html = conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(@json = conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete(@html = conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
