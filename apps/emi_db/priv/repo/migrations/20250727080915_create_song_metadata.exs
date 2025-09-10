defmodule EmiDb.Repo.Migrations.CreateAudioMedia do
  use Ecto.Migration

  def change do
    create table(:audio_media) do
      add :title, :string, null: false
      add :release_date, :utc_datetime
      add :single, :boolean
      add :length, :integer
      add :tags, :string
      add :genres, :string
      add :poster_url, :string
      add :producing_studio, :string
      add :musicbrainz_id, :string

      timestamps()
    end

    create index(:audio_media, [:musicbrainz_id], unique: true)
  end
end
