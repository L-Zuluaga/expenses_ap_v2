defmodule ExpensesAppWeb.TransactionLiveTest do
  use ExpensesAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ExpensesApp.Transactions

  @create_attrs %{amount: 42, category: "some category", from: "some from", to: "some to", type: "some type"}
  @update_attrs %{amount: 43, category: "some updated category", from: "some updated from", to: "some updated to", type: "some updated type"}
  @invalid_attrs %{amount: nil, category: nil, from: nil, to: nil, type: nil}

  defp fixture(:transaction) do
    {:ok, transaction} = Transactions.create_transaction(@create_attrs)
    transaction
  end

  defp create_transaction(_) do
    transaction = fixture(:transaction)
    %{transaction: transaction}
  end

  describe "Index" do
    setup [:create_transaction]

    test "lists all transactions", %{conn: conn, transaction: transaction} do
      {:ok, _index_live, html} = live(conn, Routes.transaction_index_path(conn, :index))

      assert html =~ "Listing Transactions"
      assert html =~ transaction.category
    end

    test "saves new transaction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_index_path(conn, :index))

      assert index_live |> element("a", "New Transaction") |> render_click() =~
               "New Transaction"

      assert_patch(index_live, Routes.transaction_index_path(conn, :new))

      assert index_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transaction-form", transaction: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_index_path(conn, :index))

      assert html =~ "Transaction created successfully"
      assert html =~ "some category"
    end

    test "updates transaction in listing", %{conn: conn, transaction: transaction} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_index_path(conn, :index))

      assert index_live |> element("#transaction-#{transaction.id} a", "Edit") |> render_click() =~
               "Edit Transaction"

      assert_patch(index_live, Routes.transaction_index_path(conn, :edit, transaction))

      assert index_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transaction-form", transaction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_index_path(conn, :index))

      assert html =~ "Transaction updated successfully"
      assert html =~ "some updated category"
    end

    test "deletes transaction in listing", %{conn: conn, transaction: transaction} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_index_path(conn, :index))

      assert index_live |> element("#transaction-#{transaction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#transaction-#{transaction.id}")
    end
  end

  describe "Show" do
    setup [:create_transaction]

    test "displays transaction", %{conn: conn, transaction: transaction} do
      {:ok, _show_live, html} = live(conn, Routes.transaction_show_path(conn, :show, transaction))

      assert html =~ "Show Transaction"
      assert html =~ transaction.category
    end

    test "updates transaction within modal", %{conn: conn, transaction: transaction} do
      {:ok, show_live, _html} = live(conn, Routes.transaction_show_path(conn, :show, transaction))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Transaction"

      assert_patch(show_live, Routes.transaction_show_path(conn, :edit, transaction))

      assert show_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#transaction-form", transaction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_show_path(conn, :show, transaction))

      assert html =~ "Transaction updated successfully"
      assert html =~ "some updated category"
    end
  end
end
