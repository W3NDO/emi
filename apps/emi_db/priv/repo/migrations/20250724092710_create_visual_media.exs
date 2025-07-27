defmodule EmiDb.Repo.Migrations.CreateVisualMedia do
  use Ecto.Migration

  def change do
    create table(:visual_media) do
      add :title, :string, null: false
      add :original_title, :string
      add :synopsis, :text
      add :release_date, :utc_datetime
      add :language, :string
      add :country, :string
      add :status, :string
      add :backdrop_url, :string
      add :keywords, :text
      add :rating, :string
      add :tags, :string

      timestamps()
    end
  end

end
