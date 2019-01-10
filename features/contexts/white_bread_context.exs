defmodule WhiteBreadContext do
  use WhiteBread.Context

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
    Hound.end_session
    nil
  end

  given_ ~r/^the following books in the library$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I want to extend the loan period of "(?<argument_one>[^"]+)" book from my borrowed books$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end

  when_ ~r/^I extend the loan period for this book$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should get an accepted message for succesfull loan$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should get a rejected message for succesfull loan$/, fn state ->
    {:ok, state}
  end

end
