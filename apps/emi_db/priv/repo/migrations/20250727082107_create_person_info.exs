defmodule EmiDb.Repo.Migrations.CreatePersonInfo do
  use Ecto.Migration

  def change do
    create table(:person_info) do
      add :full_name, :string
      add :date_of_birth, :utc_datetime
      add :nationality, :string
      add :bio, :text
      add :role, :string
      add :aliases, :string
      add :gender, :string
      add :image_url, :string
      add :imdb_id, :string
      add :social_links, :string
      add :awards, :string

      timestamps()
    end

    create index(:person_info, [:imdb_id], unique: true)
  end
end
