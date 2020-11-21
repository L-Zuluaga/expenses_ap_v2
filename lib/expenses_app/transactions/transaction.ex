defmodule ExpensesApp.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :category, :string
    field :from, :string
    field :to, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :category, :type, :from, :to])
    |> validate_required([:amount, :category, :type, :from])
  end
end
