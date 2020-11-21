defmodule ExpensesApp.Repo do
  use Ecto.Repo,
    otp_app: :expenses_app,
    adapter: Ecto.Adapters.Postgres
end
