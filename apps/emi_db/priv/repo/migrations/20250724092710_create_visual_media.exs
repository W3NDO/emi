defmodule EmiDb.Repo.Migrations.CreateVisualMedia do
  use Ecto.Migration

  def change do
    create table(:visual_media) do
      add :title, :string, null: false
      add :original_title, :string
      add :overview, :text
      add :release_date, :utc_datetime
      add :original_language, :string
      add :country, :string
      add :status, :string
      add :backdrop_path, :string
      add :poster_path, :string
      add :keywords, :text
      add :rating, :string
      add :tags, :string
      add :imdb_id, :string
      add :tmdb_id, :string
      add :adult, :boolean

      timestamps()
    end

    create index(:visual_media, [:imdb_id], unique: true)
  end

end
