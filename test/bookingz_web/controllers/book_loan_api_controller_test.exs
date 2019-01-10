defmodule BookingzWeb.BookLoanApiControllerTest do
  use BookingzWeb.ConnCase

  import Ecto.Query

  alias Bookingz.{Repo, Book}

  test "POST /book loan extension accepted", %{conn: conn} do

    [
        %{title: "Book 1", code: "A", start_date: "2019-01-10", due_date: "2019-01-17", num_of_extensions: 0},
        %{title: "Book 2", code: "A", start_date: "2018-12-19", due_date: "2018-01-16", num_of_extensions: 4}
    ]
    |> Enum.each(fn book ->
                  Repo.insert!(Book.changeset(
                                %Book{},
                                %{
                                    title: book.title,
                                    code: book.code,
                                    start_date: book.start_date,
                                    due_date: book.due_date,
                                    num_of_extensions: book.num_of_extensions
                                  }
                                )
                              )
                  end)

    book_id = Repo.one(from b in Book, where: b.title == ^"Book 1", select: b.id)

    conn = post conn, "/api/book-loans/extend", %{book_id: book_id}
    %{"response_message" => response_message} = Poison.decode! conn.resp_body

    assert response_message =~ ~r/Book loan extension has been accepted/

  end

  test "POST /book loan extension rejected", %{conn: conn} do

    [
      %{title: "Book 1", code: "A", start_date: "2019-01-10", due_date: "2019-01-17", num_of_extensions: 0},
      %{title: "Book 2", code: "A", start_date: "2018-12-19", due_date: "2018-01-16", num_of_extensions: 4}
    ]
    |> Enum.each(fn book ->
                  Repo.insert!(Book.changeset(
                                %Book{},
                                %{
                                    title: book.title,
                                    code: book.code,
                                    start_date: book.start_date,
                                    due_date: book.due_date,
                                    num_of_extensions: book.num_of_extensions
                                  }
                                )
                              )
                  end)

    book_id = Repo.one(from b in Book, where: b.title == ^"Book 2", select: b.id)

    conn = post conn, "/api/book-loans/extend", %{book_id: book_id}
    %{"response_message" => response_message} = Poison.decode! conn.resp_body

    assert response_message =~ ~r/Book loan extension has been rejected/

  end

end
