defmodule VisualMediaTest do
  use ExUnit.Case, async: true
  alias EmiDb.{VisualMedia, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    visual_media_attrs = %{
      title: "Spirited Away",
      original_title: "千と千尋の神隠し",
      synopsis: "A young girl enters a world of spirits and must find her way back.",
      release_date: ~U[1988-12-24 00:00:00Z],
      language: "Japanese",
      country: "Japan",
      status: "Released",
      backdrop_url: "https://example.com/spirited_away.jpg",
      keywords: "spirits, bathhouse, adventure",
      rating: "PG",
      tags: "anime, fantasy, coming-of-age",
      imdb_id: "tt0245429"
    }

    {:ok, _existing_visual_media} =
      Repo.insert(VisualMedia.changeset(%VisualMedia{}, visual_media_attrs))

    {:ok, visual_media_attrs: visual_media_attrs}
  end

  test "Ensure uniqueness of IMDB ID", %{
    visual_media_attrs: visual_media_attrs
  } do
    changeset = VisualMedia.changeset(%VisualMedia{}, visual_media_attrs)

    assert {:error, changeset} = Repo.insert(changeset)

    assert {"has already been taken",
            [constraint: :unique, constraint_name: "visual_media_imdb_id_index"]} ==
             changeset.errors[:imdb_id]
  end
end
