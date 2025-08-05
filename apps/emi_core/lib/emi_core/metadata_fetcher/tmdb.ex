defmodule EmiCore.MetadataFetcher.Tmdb do
  @behaviour Fetcher
  alias EmiCore.MetadataFetcher.Fetcher

  @base_url URI.parse("https://api.themoviedb.org/3/search")

  @type media_type :: :movie | :show | nil
  @type query_params :: %{
          query: String.t(),
          include_adult: boolean(),
          language: String.t(),
          primary_release_year: String.t(),
          page: integer(),
          region: String.t(),
          year: String.t()
        }

  @doc """
    https://developer.themoviedb.org/reference/search-movie

    Of importance here is that the search term from the TMDB API will be a query param
    Other importanat query params
      - include_adult?            : boolean
      - language                  : string(default to en-US)
      - primary_release_year      : string
      - page                      : integer
      - region                    : string
      - year                      : string
  """
  @impl Fetcher
  @spec build_request(query_params(), media_type(), map) :: %Req.Request{}
  def build_request(query_params, media_type, options) do
    url = build_url(@base_url, media_type, query_params)
    Req.Request.new(url: url, headers: options.headers)
  end

  @doc """
  This makes the request to TMDB. It accepts a %Req.Request{} struct and returns a tuple, {:ok, response_body} or {:error, response.status}

  """
  @impl Fetcher
  @spec make_request(%Req.Request{}) :: {:ok, map} | {:error, integer}
  def make_request(req) do
    {req, response} = Req.Request.run_request(req)

    case response.status do
      200 -> {:ok, response.body}
      _ -> {:error, response.status}
    end
  end

  defp build_url(base_url, media_type, query_params) do
    media_type =
      case media_type do
        :movie -> "movie"
        :show -> "tv"
        _ -> "multi"
      end

    "#{base_url}" <>
      "/#{media_type}?" <>
      "#{Enum.map(query_params, fn {k, v} -> "#{k}=#{v}" end) |> Enum.join("&")}"
  end
end
