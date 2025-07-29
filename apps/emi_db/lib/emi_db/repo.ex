defmodule EmiDb.Repo do
  use Ecto.Repo,
    otp_app: :emi_db,
    adapter: Ecto.Adapters.SQLite3
end
