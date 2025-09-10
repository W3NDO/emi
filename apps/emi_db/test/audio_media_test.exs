defmodule AudioMediaTest do
  use ExUnit.Case, async: true
  alias EmiDb.{AudioMedia, Repo}

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

    {:ok, _existing_song} = Repo.insert(AudioMedia.changeset(%AudioMedia{}, song_attrs))

    {:ok, song_attrs: song_attrs}
  end

  test "Ensure uniqueness of Musicbrainz ID", %{
    song_attrs: song_attrs
  } do
    changeset = AudioMedia.changeset(%AudioMedia{}, song_attrs)

    assert {:error, changeset} = Repo.insert(changeset)

    assert {"has already been taken",
            [constraint: :unique, constraint_name: "audio_media_musicbrainz_id_index"]} ==
             changeset.errors[:musicbrainz_id]
  end
end
