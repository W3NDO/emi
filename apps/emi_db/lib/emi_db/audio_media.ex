defmodule EmiDb.AudioMedia do
  use Ecto.Schema
  import Ecto.Changeset

  schema "audio_media" do
    field(:title, :string)
    field(:release_date, :utc_datetime)
    field(:single, :boolean)
    field(:length, :integer)
    field(:tags, :string)
    field(:genres, :string)
    field(:poster_url, :string)
    field(:producing_studio, :string)
    field(:musicbrainz_id, :string)

    timestamps()
  end

  def changeset(audio_media, attrs) do
    audio_media
    |> cast(attrs, [
      :title,
      :release_date,
      :single,
      :length,
      :tags,
      :genres,
      :poster_url,
      :producing_studio,
      :musicbrainz_id
    ])
    |> validate_required([:title])
    |> unique_constraint([:musicbrainz_id])
  end
end
