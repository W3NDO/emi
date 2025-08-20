defmodule EmiCore do
  alias EmiCore.MetadataFetcher.Tmdb
  alias EmiCore.Scanner.Scanner
  alias EmiCore.Query.MediaQuery

  @api_key System.get_env("TMDB_READ_ACCESS_TOKEN")

  def scan_and_persist(dir_path) do
    entries =
      Scanner.get_dir_entries(dir_path)
      |> Enum.map(fn path -> Scanner.build_media_structs(path) end)
      |> Enum.map(fn struct -> build_query_params(struct.name) end)
      |> Enum.map(fn query_params -> Tmdb.build_request(query_params, :multi) end)
      |> Enum.map(fn request_object -> Tmdb.make_request(request_object) end)
      |> Enum.map(fn {:ok, body} -> MediaQuery.insert_to_repo(body, :visual) end)
  end

  defp build_query_params(query) do
    %{
      query: query,
      include_adult: true,
      language: "en-UK",
      options: %{
        headers: [{"accept", "application/json"}, {"Authorization", "Bearer #{@api_key}"}]
      }
    }
  end
end
