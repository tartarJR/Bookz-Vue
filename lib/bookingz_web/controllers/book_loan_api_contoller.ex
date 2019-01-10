defmodule BookingzWeb.BookLoanApiController do
  use BookingzWeb, :controller

  alias Bookingz.{Repo, Book}

  def getBookLoans(conn, %{ "should_show_all_books" => should_show_all_books }) do

    books = Repo.all(Book)
    books = books
            |> Enum.map(fn book ->
              if Date.diff(book.due_date,Date.utc_today) < 0 do
                %{
                  id: book.id,
                  title: book.title,
                  start_date: book.start_date,
                  due_date: book.due_date,
                  num_of_extensions: book.num_of_extensions,
                  should_show_action: false
                }
              else
                %{
                  id: book.id,
                  title: book.title,
                  start_date: book.start_date,
                  due_date: book.due_date,
                  num_of_extensions: book.num_of_extensions,
                  should_show_action: true
                }
              end
            end)

    if should_show_all_books do
      conn
      |> put_status(200)
      |> json(%{ books: books })
    else
      filtered_books = books |> Enum.filter(fn book -> Date.diff(book.due_date, Date.utc_today) > 0 end)

      conn
      |> put_status(200)
      |> json(%{ books: filtered_books })
    end

  end

  def extendBookLoan(conn, %{ "book_id" => book_id })do

    book = Repo.get(Book, book_id)

    extension_days = cond do
                      book.code == "A" ->  7
                      book.code == "B" ->  14
                      book.code == "C" ->  21
                     end

    if book.num_of_extensions != 4 do

      due_date = Date.add(book.due_date, extension_days)
      Repo.update(Book.changeset(book,%{num_of_extensions: book.num_of_extensions + 1, due_date: due_date }))

      conn
      |> put_status(200)
      |> json(%{ response_message: "Book loan extension has been accepted" })
    else
      conn
      |> put_status(200)
      |> json(%{ response_message: "Book loan extension has been rejected" })
    end

  end

end
