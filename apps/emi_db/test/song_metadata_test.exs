defmodule SongMetadataTest do
  use ExUnit.Case, async: true
  alias EmiDb.{SongMetadata, Repo}
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    song_attrs = %{
      title: "Blue Bird",
      release_date: ~U[1988-12-24 00:00:00Z],
      single: true,
      length: 225,
      tags: "anime,naruto,opener",
      genres: "J-pop,Rock",
      poster_url: "https://example.com/blue_bird.jpg",
      producing_studio: "Sony Music Japan",
      musicbrainz_id: "c9fdb94c-4975-4ed6-a96f-ef6d80bb7738"
    }

    {:ok, existing_song} = Repo.insert(SongMetadata.changeset(%SongMetadata{}, song_attrs))

    {:ok, song_attrs: song_attrs, existing_song: existing_song}
  end

  test "Ensure uniqueness of Musicbrainz ID", %{
    existing_song: existing_song,
    song_attrs: song_attrs
  } do
    changeset = SongMetadata.changeset(%SongMetadata{}, song_attrs)

    assert {:error, changeset} = Repo.insert(changeset)

    assert {"has already been taken",
            [constraint: :unique, constraint_name: "song_metadata_musicbrainz_id_index"]} ==
             changeset.errors[:musicbrainz_id]
  end
end
