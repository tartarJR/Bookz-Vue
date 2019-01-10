defmodule BookingzWeb.BookLoanApiController do
  use BookingzWeb, :controller

  alias Bookingz.{Repo, Book}

  def getBookLoans(conn, %{"should_show_all_books" => should_show_all_books }) do

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

end
