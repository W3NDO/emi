defmodule EmiCore.MetadataFetcher.Musicbrainz do
  alias EmiCore.MetadataFetcher.Fetcher
  @behaviour Fetcher

  @impl Fetcher
  def build_request(url, body) do
    %{}
  end

  @impl Fetcher
  def make_request(request) do
    {:ok, %{}}
  end
end
