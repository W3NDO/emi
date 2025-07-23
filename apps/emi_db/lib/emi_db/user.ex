defmodule EmiDb.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :role])
    |> validate_required([:username, :role])
    |> unique_constraint(:username)
  end
end
