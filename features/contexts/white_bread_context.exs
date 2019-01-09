defmodule WhiteBreadContext do
  use WhiteBread.Context

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
