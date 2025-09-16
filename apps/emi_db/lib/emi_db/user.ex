defmodule EmiDb.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:password_hash, :string)
    field(:role, :boolean, default: false)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :role])
    |> validate_required([:username, :password_hash, :role])
    |> unique_constraint(:username)
    |> put_password_hash()
  end

   defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} = changeset
       ) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password_hash))
  end

  defp put_password_hash(changeset), do: changeset
end
