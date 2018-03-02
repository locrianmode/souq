defmodule SouqWeb.TestController do
  use SouqWeb, :controller

  alias Souq.Accounts
  alias Souq.Accounts.Test

  def index(conn, _params) do
    tests = Accounts.list_tests()
    render(conn, "index.html", tests: tests)
  end

  def new(conn, _params) do
    changeset = Accounts.change_test(%Test{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"test" => test_params}) do
    case Accounts.create_test(test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test created successfully.")
        |> redirect(to: test_path(conn, :show, test))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test = Accounts.get_test!(id)
    render(conn, "show.html", test: test)
  end

  def edit(conn, %{"id" => id}) do
    test = Accounts.get_test!(id)
    changeset = Accounts.change_test(test)
    render(conn, "edit.html", test: test, changeset: changeset)
  end

  def update(conn, %{"id" => id, "test" => test_params}) do
    test = Accounts.get_test!(id)

    case Accounts.update_test(test, test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test updated successfully.")
        |> redirect(to: test_path(conn, :show, test))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", test: test, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test = Accounts.get_test!(id)
    {:ok, _test} = Accounts.delete_test(test)

    conn
    |> put_flash(:info, "Test deleted successfully.")
    |> redirect(to: test_path(conn, :index))
  end
end
