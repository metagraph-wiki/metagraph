defmodule FrontendWeb.PageController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def profile(conn, _params) do
    conn
    |> render("profile.html",
      changeset: Database.Account.update_changeset(conn.assigns.current_user)
    )
  end

  def update(conn, %{"account" => params}) do
    Database.Account.update_changeset(conn.assigns.current_user, params)
    |> Database.Repo.update()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Saved!")
        |> render("profile.html", changeset: Database.Account.update_changeset(user))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Unable to save!")
        |> render("profile.html", changeset: changeset)
    end
  end

  def help(conn, _params) do
    render(conn, "help.html", page_title: "Help")
  end

  def terms(conn, _params) do
    render(conn, "terms.html", page_title: "Terms of Service")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html", page_title: "Privacy Policy")
  end
end
