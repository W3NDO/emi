defmodule PersonInfoTest do
  use ExUnit.Case, async: true
  alias EmiDb.{PersonInfo, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    person_attrs = %{
      full_name: "Nura Habib Omer",
      date_of_birth: ~U[1988-12-24 00:00:00Z],
      nationality: "German",
      bio:
        "Nura Habib Omer (Arabic: نورا حبيب عمر, born 24 December 1988[1]) is a Kuwait-born German rapper and actor of Eritrean descent.[2] She is known for being part of The toten Crackhuren im Kofferraum and the rap duo SXTN.[3] Following the split of SXTN in 2018, she has pursued a solo career.[4] As an actor she is best known for playing Flora in the Amazon Prime Video series Die Discounter",
      role: "Artist",
      aliases: "",
      gender: "female",
      image_url:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Nura_-_Openair_Frauenfeld_2019_06.jpg/250px-Nura_-_Openair_Frauenfeld_2019_06.jpg",
      imdb_id: "nm7693815",
      social_links: "",
      awards: ""
    }

    {:ok, _existing_person} = Repo.insert(PersonInfo.changeset(%PersonInfo{}, person_attrs))

    {:ok, person_attrs: person_attrs}
  end

  test "Ensure uniqueness of IMDB id", %{
    person_attrs: person_attrs
  } do
    changeset = PersonInfo.changeset(%PersonInfo{}, person_attrs)

    assert {:error, changeset} = Repo.insert(changeset)

    assert {"has already been taken",
            [constraint: :unique, constraint_name: "person_info_imdb_id_index"]} ==
             changeset.errors[:imdb_id]
  end
end
