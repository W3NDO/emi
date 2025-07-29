defmodule EmiDb.VisualMedia do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visual_media" do
    field(:title, :string)
    field(:original_title, :string)
    field(:synopsis, :string)
    field(:release_date, :utc_datetime)
    field(:language, :string)
    field(:country, :string)
    field(:status, :string)
    field(:backdrop_url, :string)
    field(:keywords, :string)
    field(:rating, :string)
    field(:tags, :string)
    field(:imdb_id, :string)

    # field :video_codec, :string
    # field :audio_codec, :string
    # field :resulution, :string
    # field :bitrate, :string
    # has_many Subtitles
    # has_many Genres
    # field :gallery -> :attached images
    # field :poster, :attached_image
    # has_many People -> cast
    # has_many People -> directors
    # has_many People -> Writers
    # has_many People -> Producers
    # has_many People -> Crew
    # has_man
    timestamps()
  end

  def changeset(visual_media, attrs) do
    visual_media
    |> cast(attrs, [
      :title,
      :original_title,
      :synopsis,
      :release_date,
      :language,
      :country,
      :status,
      :backdrop_url,
      :keywords,
      :rating,
      :tags,
      :imdb_id
    ])
    |> validate_required([:title])
    |> unique_constraint([:imdb_id])
  end
end
