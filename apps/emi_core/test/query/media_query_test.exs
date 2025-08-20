defmodule EmiCore.QueryTest do
  use ExUnit.Case, async: true
  alias EmiDb.{Repo, VisualMedia, AudioMedia}
  alias EmiCore.Query.MediaQuery

  setup do
    single_visual_media = %{
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

    single_audio_media = %{
      "artists" => [
        %{
          "aliases" => [
            %{
              "begin-date" => nil,
              "end-date" => nil,
              "locale" => nil,
              "name" => "نورا حبيب عمر",
              "primary" => nil,
              "sort-name" => "نورا حبيب عمر",
              "type" => nil
            },
            %{
              "begin-date" => nil,
              "end-date" => nil,
              "locale" => nil,
              "name" => "Nura Habib Omer",
              "primary" => nil,
              "sort-name" => "Omer, Nura Habib",
              "type" => "Legal name",
              "type-id" => "d4dcd0c0-b341-3612-a332-c0ce797b25cf"
            }
          ],
          "area" => %{
            "id" => "85752fda-13c4-31a3-bee5-0e5cb1f51dad",
            "life-span" => %{"ended" => nil},
            "name" => "Germany",
            "sort-name" => "Germany",
            "type" => "Country",
            "type-id" => "06dd0ae4-8c74-30bb-b43d-95dcedf961de"
          },
          "begin-area" => %{
            "id" => "06141a32-eef4-462a-8c6b-52a11cc3241f",
            "life-span" => %{"ended" => nil},
            "name" => "Kuwait City",
            "sort-name" => "Kuwait City",
            "type" => "City",
            "type-id" => "6fd8f29a-3d0a-32fc-980d-ea697b69da78"
          },
          "country" => "DE",
          "disambiguation" => "Female rapper from Berlin-Neukölln",
          "gender" => "female",
          "gender-id" => "93452b5a-a947-30c8-934f-6a4056b151c2",
          "id" => "ff7e8ee9-e01f-4153-b442-c28aab40efa8",
          "isnis" => ["0000000475879152"],
          "life-span" => %{"begin" => "1988-12-24", "ended" => nil},
          "name" => "Nura",
          "score" => 100,
          "sort-name" => "Nura",
          "tags" => [
            %{"count" => 1, "name" => "actor"},
            %{"count" => 1, "name" => "hip hop"}
          ],
          "type" => "Person",
          "type-id" => "b6e035f4-3ce9-331c-97df-83397230b0df"
        }
      ],
      "count" => 2327,
      "created" => "2025-08-13T11:19:03.369Z",
      "offset" => 0
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

    {:ok, single_visual_media: single_visual_media, multiple_media: multiple_media}
  end

  describe "Fetch data about movies and update records in the DB." do
    test "Creates a new visual media entry", %{single_visual_media: single_visual_media} do
      # changeset = VisualMedia.changeset(%VisualMedia{}, single_visual_media)
      assert {:ok, _} = MediaQuery.insert_to_repo(single_visual_media, :visual)
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
