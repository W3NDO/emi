defmodule EmiCore.QueryTest do
  use ExUnit.Case, async: true
  alias EmiDb.{Repo, VisualMedia}
  alias EmiCore.Query.MediaQuery

  setup do
    single_media = %{
      adult: false,
      backdrop_path: "/vL5LR6WdxWPjLPFRLe133jXWsh5.jpg",
      genre_ids: [28, 12, 14, 878],
      id: 19995,
      original_language: "en",
      original_title: "Avatar",
      synopsis:
        "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
      poster_path: "/kyeqWdyUXW608qlYkRqosgbbJyK.jpg",
      release_date: "2009-12-15",
      title: "Avatar"
    }

    multiple_media = [
      %{
        adult: false,
        backdrop_path: "/mbYTRO33LJAgpCMrIn9ibiWHbMH.jpg",
        genre_ids: [35, 12],
        id: 346_698,
        original_language: "en",
        original_title: "Barbie",
        synopsis:
          "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.",
        poster_path: "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
        release_date: "2023-06-18",
        title: "Barbie"
      },
      %{
        adult: false,
        backdrop_path: "/vL5LR6WdxWPjLPFRLe133jXWsh5.jpg",
        genre_ids: [28, 12, 14, 878],
        id: 19995,
        original_language: "en",
        original_title: "Avatar",
        synopsis:
          "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
        poster_path: "/kyeqWdyUXW608qlYkRqosgbbJyK.jpg",
        release_date: "2009-12-15",
        title: "Avatar"
      }
    ]

    {:ok, single_media: single_media, multiple_media: multiple_media}
  end

  describe "Fetch data about movies and update records in the DB." do
    test "Creates a new visual media entry", %{single_media: single_media} do
      # changeset = VisualMedia.changeset(%VisualMedia{}, single_media)
      assert {:ok, _} = MediaQuery.insert_to_repo(single_media, :visual)
    end

    @tag :skip
    test "creates a list of visual media changesets and inserts them in batch" do
      assert false = true
    end
  end

  describe "Fetch data from musicbrainz and update records in the DB" do
    @tag :skip
    test "Creates a new audio media entry" do
      assert false = true
    end

    @tag :skip
    test "creates a list of audio media changesets and inserts them in batch " do
      assert false = true
    end
  end
end
