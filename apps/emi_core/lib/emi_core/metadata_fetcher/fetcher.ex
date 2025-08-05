defmodule EmiCore.MetadataFetcher.Fetcher do
  @moduledoc """
    Specifies functions that should be implemented in fetching data from IMDB, MusicBrainz and any other API down the line.

  """

  @doc """
  Creates a Req.Request object with the URL, query_params, header options passed as a map. Returns a request object
  """
  @callback build_request(map, map) :: %Req.Request{}

  @doc """
    Actually makes the request and returns either {:ok, body} or {:error, status_code}
  """
  @callback make_request(%Req.Request{}) :: {:ok, map} | {:error, integer}
end
