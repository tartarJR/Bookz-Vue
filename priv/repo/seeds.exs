# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bookingz.Repo.insert!(%Bookingz.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bookingz.{Repo, Book}
[
  %{title: "Book 1", code: "A", start_date: "2019-01-10", due_date: "2019-01-17", num_of_extensions: 0},
  %{title: "Book 2", code: "A", start_date: "2018-12-19", due_date: "2018-01-16", num_of_extensions: 4},
  %{title: "Book 3", code: "A", start_date: "2018-08-07", due_date: "2018-08-21", num_of_extensions: 1},
  %{title: "Book 4", code: "C", start_date: "2018-06-03", due_date: "2018-06-24", num_of_extensions: 0},
  %{title: "Book 5", code: "C", start_date: "2018-05-12", due_date: "2018-06-03", num_of_extensions: 0},
  %{title: "Book 6", code: "C", start_date: "2018-05-15", due_date: "2018-06-05", num_of_extensions: 0},
  %{title: "Book 7", code: "C", start_date: "2019-01-15", due_date: "2019-01-25", num_of_extensions: 3}
 ]
 |> Enum.each(
      fn book -> Repo.insert!(Book.changeset(%Book{},
        %{
            title: book.title,
            code: book.code,
            start_date: Date.from_iso8601!(book.start_date),
            due_date: Date.from_iso8601!(book.due_date),
            num_of_extensions: book.num_of_extensions
        }))
      end
    )
