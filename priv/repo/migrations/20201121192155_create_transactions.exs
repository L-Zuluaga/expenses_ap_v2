defmodule ExpensesApp.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :category, :string
      add :type, :string
      add :from, :string
      add :to, :string

      timestamps()
    end

  end
end
