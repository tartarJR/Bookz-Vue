defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  alias Bookingz.{Repo, Book}

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(Repo)
    #Hound.end_session
    nil
  end

  given_ ~r/^the following books in the library$/, fn state, %{table_data: table} ->
    table
    |>  Enum.each(fn book ->
        Repo.insert!(Book.changeset(
                      %Book{},
                      %{
                        title: book.title,
                        code: book.code,
                        start_date: book.start_date,
                        due_date: book.due_date,
                        num_of_extensions: book.num_of_extensions
                      })) end)

        {:ok, state}
  end

  and_ ~r/^I want to extend the loan period of "(?<argument_one>[^"]+)" book from my borrowed books$/,
  fn state, %{argument_one: argument_one} ->
    navigate_to "/#/"
    {:ok, state |> Map.put(:item_id, argument_one)}
  end

  when_ ~r/^I extend the loan period for this book$/, fn state ->
    IO.puts state[:item_id]
    click({:id, state[:item_id]})
    {:ok, state}
  end

  then_ ~r/^I should get an accepted message for succesfull loan$/, fn state ->
    assert visible_in_page? ~r/#{"Book loan extension has been accepted"}/
    {:ok, state}
  end

  then_ ~r/^I should get a rejected message for unsuccesfull loan$/, fn state ->
    assert visible_in_page? ~r/#{"Book loan extension has been rejected"}/
    {:ok, state}
  end

end
