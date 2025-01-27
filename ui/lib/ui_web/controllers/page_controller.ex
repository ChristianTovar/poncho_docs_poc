defmodule UiWeb.PageController do
  use UiWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def docs(conn, _params) do
    redirect(conn, to: "/doc/index.html")
  end
end
