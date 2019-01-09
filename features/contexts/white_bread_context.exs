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

  given_ ~r/^the following books are in library$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I want to extend the time of "(?<argument_one>[^"]+)" book in my borrowing list$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end

  when_ ~r/^I extend it$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a rejected message for unsuccesfull operation$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a accepted message for succesfull operation$/, fn state ->
    {:ok, state}
  end

end
