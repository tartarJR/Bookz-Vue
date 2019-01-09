defmodule Bookingz.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :code, :string
    field :due_date, :date
    field :num_of_extensions, :integer
    field :start_date, :date
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :code, :start_date, :due_date, :num_of_extensions])
    |> validate_required([:title, :code, :start_date, :due_date, :num_of_extensions])
  end
end
