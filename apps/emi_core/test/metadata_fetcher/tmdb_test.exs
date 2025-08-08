defmodule MetadataFetcher.TmdbTest do
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Tmdb

  setup do
    {:ok,
     query_params: %{
       query: "avatar",
       include_adult: true,
       language: "en-UK"
     },
     options: %{headers: [{"accept", "application/json"}, {"Authorization", "Bearer 19995"}]}}
  end

  describe "preparing requests" do
    test "generated URL is correct with query params and movie media type", %{
      query_params: query_params,
      options: options
    } do
      expected_uri = URI.parse(
               "https://api.themoviedb.org/3/search/movie?query=avatar&language=en-UK&include_adult=true"
             )
      assert expected_uri = Tmdb.build_request(query_params, :movie, options).url
    end

    test "generated URL is correct with query params and no media type", %{
      query_params: query_params,
      options: options
    } do
      expected_uri = URI.parse(
               "https://api.themoviedb.org/3/search/multi?query=avatar&language=en-UK&include_adult=true"
             )
      assert expected_uri = Tmdb.build_request(query_params, nil, options).url
    end

    test "generated URL is correct with query params and tv show media type", %{
      query_params: query_params,
      options: options
    } do
      assert URI.parse(
               "https://api.themoviedb.org/3/search/tv?query=avatar&language=en-UK&include_adult=true"
             ) == Tmdb.build_request(query_params, :show, options).url
    end

    test "generated headers are correct", %{
      query_params: query_params,
      options: options
    } do
      assert headers:
               %{
                 "Authorization" => ["Bearer 199**"],
                 "accept" => ["application/json"]
               } == Tmdb.build_request(query_params, :movie, options).headers
    end
  end
end
