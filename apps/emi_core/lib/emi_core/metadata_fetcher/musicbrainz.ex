defmodule EmiCore.MetadataFetcher.Musicbrainz do
  alias EmiCore.MetadataFetcher.Fetcher
  @behaviour Fetcher
  @artist_base_path URI.parse("http://musicbrainz.org/ws/2/artist/")
  @song_base_path URI.parse("http://musicbrainz.org/ws/2/recording/")

  @type query_params :: %{
          query: String.t(),
          fmt: String.t()
        }

  @doc """
    https://musicbrainz.org/doc/MusicBrainz_API/Search

    The query params here include just having the name of the artist or song and the format of the return data.

    We use JSON return by default.
  """
  @impl Fetcher
  def build_request(query_params, artist_or_recording \\ nil) do
    url = build_url(artist_or_recording, query_params.query)
    Req.Request.new(url: url)
  end

  @impl Fetcher
  @spec make_request(%Req.Request{}) :: {:ok, map} | {:error, integer}
  def make_request(request) do
    {_req, response} = Req.Request.run_request(request)

    case response.status do
      200 -> {:ok, response.body}
      404 -> {:error, :not_found}
      500 -> {:error, :server_error}
      _ -> {:error, response.status}
    end
  end

  defp build_url(artist_or_recording, query_value) do
    path =
      case artist_or_recording do
        :artist -> @artist_base_path
        :recording -> @song_base_path
        _ -> @song_base_path
      end

    query_params = %{
      query: query_value,
      fmt: "json",
      limit: 1
    }

    %URI{path | query: URI.encode_query(query_params)}
  end
end
