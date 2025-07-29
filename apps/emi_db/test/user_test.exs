defmodule UserTest do
  use ExUnit.Case, async: true
  alias EmiDb.{User, Repo}
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    existing_username = Faker.Internet.user_name()

    {:ok, existing_user} =
      Repo.insert(User.changeset(%User{}, %{username: existing_username, role: "user"}))

    {:ok, existing_user: existing_user, existing_username: existing_username}
  end

  test "inserts a record" do
    username = Faker.Internet.user_name()
    changeset = User.changeset(%User{}, %{username: username, role: "admin"})
    {:ok, user} = Repo.insert(changeset)

    assert user.username == username
    assert user.role == "admin"
    assert user
  end

  test "fetches a record", %{existing_user: existing_user, existing_username: existing_username} do
    fetched = Repo.get(User, existing_user.id)
    assert fetched.username == existing_username
  end

  test "updates a record", %{existing_user: existing_user} do
    user = Repo.get(User, existing_user.id)
    changeset = Ecto.Changeset.change(user, %{role: "admin"})
    Repo.update(changeset)
    fetched = Repo.get(User, existing_user.id)

    assert fetched.role == "admin"
  end

  test "deletes a record", %{existing_user: existing_user} do
    Repo.delete(existing_user)

    assert nil == Repo.get(User, existing_user.id)
  end

  test "Ensures uniqueness constraint", %{existing_user: existing_user} do
    duplicate_attrs = %{username: existing_user.username, role: "user"}

    changeset = User.changeset(%User{}, duplicate_attrs)

    assert {:error, changeset} = Repo.insert(changeset)

    assert changeset.errors[:username] ==
             {"has already been taken",
              [constraint: :unique, constraint_name: "users_username_index"]}
  end
end
