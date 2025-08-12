defmodule EmiCore.MetadataFetcher.Tmdb do
  @behaviour EmiCore.MetadataFetcher.Fetcher
  alias EmiCore.MetadataFetcher.Fetcher

  @movie_base_path URI.parse("https://api.themoviedb.org/3/search/movie")
  @tv_base_path URI.parse("https://api.themoviedb.org/3/search/tv")
  @multi_base_path URI.parse("https://api.themoviedb.org/3/search/multi")

  @type media_type :: :movie | :show | nil
  @type query_params :: %{
          query: String.t(),
          include_adult: boolean(),
          language: String.t(),
          primary_release_year: String.t(),
          page: integer(),
          region: String.t(),
          year: String.t(),
          options: map()
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
  @spec build_request(query_params(), media_type()) :: %Req.Request{}
  def build_request(query_params_and_options, media_type \\ nil) do
    {query_params, options} =
      Map.split(query_params_and_options, [
        :query,
        :include_adult,
        :language,
        :primary_release_year,
        :page,
        :region,
        :year
      ])

    url = build_url(media_type, query_params)
    Req.Request.new(url: url, headers: options.options.headers)
  end

  @doc """
  This makes the request to TMDB. It accepts a %Req.Request{} struct and returns a tuple, {:ok, response_body} or {:error, response.status}

  """
  @impl Fetcher
  @spec make_request(%Req.Request{}) :: {:ok, map} | {:error, integer} | {:error, atom}
  def make_request(req) do
    {_req, response} = Req.Request.run_request(req)

    case response.status do
      200 -> {:ok, response.body}
      404 -> {:error, :not_found}
      500 -> {:error, :server_error}
      401 -> {:error, :unauthorised}
      _ -> {:error, response.status}
    end
  end

  defp build_url(media_type, query_params) do
    path =
      case media_type do
        :movie -> @movie_base_path
        :show -> @tv_base_path
        _ -> @multi_base_path
      end

    # because the multi endpoint gives us the media type with the search, we could in fact just use the multipath
    %URI{path | query: URI.encode_query(query_params)}
  end
end
