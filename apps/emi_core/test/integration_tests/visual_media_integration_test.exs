defmodule IntegrationTests.VisualMediaIntegrationTest do
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Tmdb
  alias EmiCore.Scanner.Scanner
  alias EmiCore.Query.MediaQuery

  setup do
    api_key = System.get_env("TMDB_READ_ACCESS_TOKEN")

    {:ok, api_key: api_key}
  end

  # TODO What flow are we testing.

  @tag :integration_test
  @tag :tmp_dir
  @tag :skip
  test "read file info, read env variable, fetch data from tmdb, insert into repo", %{
    tmp_dir: dir,
    api_key: api_key
  } do
    # scanning for media
    dir |> Path.join("Ballerina.mp4") |> File.write("Hola")
    entries = Scanner.get_dir_entries(dir)
    first_entry = Enum.map(entries, fn path -> Scanner.build_media_structs(path) end) |> hd()

    # Scanner works
    assert "Ballerina" == first_entry.name

    # Building the query
    query_params = %{
      query: first_entry.name,
      include_adult: true,
      language: "en-UK",
      options: %{
        headers: [{"accept", "application/json"}, {"Authorization", "Bearer #{api_key}"}]
      }
    }

    request_body = Tmdb.build_request(query_params, :movie)
    res = Tmdb.make_request(request_body)
    # assert a 200 ok response.
    assert {:ok, _} = res

    {:ok, body} = res
    # Insert into the database
    assert {:ok, _entry} = MediaQuery.insert_to_repo(body, :visual)
  end

  @tag :integration_test
  @tag :tmp_dir
  test "scan_and_persist method from EmiCore", %{tmp_dir: dir} do
    dir |> Path.join("John Wick.mp4") |> File.write("Hola")
    assert [{:ok, repo} | _] = EmiCore.scan_and_persist(dir)
  end
end
