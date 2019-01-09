defmodule Bookingz.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :code, :string
      add :start_date, :date
      add :due_date, :date
      add :num_of_extensions, :integer

      timestamps()
    end

  end
end
