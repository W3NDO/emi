defmodule EmiDb.PersonInfo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "person_info" do
    field(:full_name, :string)
    field(:date_of_birth, :utc_datetime)
    field(:nationality, :string)
    field(:bio, :string)
    field(:role, :string)
    field(:aliases, :string)
    field(:gender, :string)
    field(:image_url, :string)
    field(:imdb_id, :string)
    field(:social_links, :string)
    field(:awards, :string)

    timestamps()
  end

  def changeset(person_info, attrs) do
    person_info
    |> cast(attrs, [
      :full_name,
      :date_of_birth,
      :nationality,
      :bio,
      :role,
      :aliases,
      :gender,
      :image_url,
      :imdb_id,
      :social_links,
      :awards
    ])
    |> validate_required([:full_name])
    |> unique_constraint([:imdb_id])
  end
end
