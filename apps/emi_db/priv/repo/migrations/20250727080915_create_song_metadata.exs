defmodule EmiDb.Repo.Migrations.CreateSongMetadata do
  use Ecto.Migration

  def change do
    create table(:song_metadata) do
      add :title, :string, null: false
      add :release_date, :utc_datetime
      add :single, :boolean
      add :length, :integer
      add :tags, :string
      add :genres, :string
      add :poster_url, :string
      add :producing_studio, :string

      timestamps()
    end
  end
end
