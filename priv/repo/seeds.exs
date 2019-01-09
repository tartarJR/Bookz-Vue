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
  %{title: "Book 1", code: "A", startdate: "2019-01-10", duedate: "2019-01-17", timeextended: 3},
  %{title: "Book 2", code: "C", startdate: "2019-12-12", duedate: "2019-01-03", timeextended: 1},
  %{title: "Book 3", code: "C", startdate: "2019-08-07", duedate: "2017-08-21", timeextended: 2},
  %{title: "Book 4", code: "B", startdate: "2019-06-03", duedate: "2017-06-24", timeextended: 4},
  %{title: "Book 5", code: "A", startdate: "2019-06-22", duedate: "2019-06-25", timeextended: 0}
 ]
 |> Enum.each(
      fn item -> Repo.insert!(Book.changeset(%Book{},
        %{ title: item.title,
          code: item.code,
          start_date: Date.from_iso8601!(item.startdate),
          due_date: Date.from_iso8601!(item.duedate),
          num_of_extensions: item.timeextended
        }))
      end
    )
