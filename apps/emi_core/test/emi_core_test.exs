defmodule EmiCoreTest do
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Tmdb
  alias EmiCore.Scanner.Scanner
  alias EmiCore.Query.MediaQuery

  setup do
    api_key = System.get_env("TMDB_READ_ACCESS_TOKEN")

    {:ok, api_key: api_key}
  end

  @tag :integration_test
  @tag :tmp_dir
  test "scan_and_persist method from EmiCore", %{tmp_dir: dir} do
    dir |> Path.join("John Wick.mp4") |> File.write("Hola")
    assert [{:ok, repo} | _] = EmiCore.scan_and_persist(dir)
  end
end
