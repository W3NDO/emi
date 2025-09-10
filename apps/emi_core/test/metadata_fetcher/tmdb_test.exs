defmodule MetadataFetcher.TmdbTest do
  import Mox
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Tmdb
  alias EmiCore.MetadataFetcher.MockFetcher

  setup do
    :verify_on_exit!

    query_params = %{
      query: "avatar",
      include_adult: true,
      language: "en-UK",
      options: %{headers: [{"accept", "application/json"}, {"Authorization", "Bearer 19995"}]}
    }

    request_body = Tmdb.build_request(query_params, :movie)
    mock_mod = Application.get_env(:emi_core, :make_request)

    {:ok, query_params: query_params, request_body: request_body, mock_mod: mock_mod}
  end

  describe "preparing requests" do
    test "generated URL is correct with query params and movie media type", %{
      query_params: query_params
    } do
      expected_uri =
        URI.parse(
          "https://api.themoviedb.org/3/search/movie?query=avatar&language=en-UK&include_adult=true"
        )

      assert expected_uri == Tmdb.build_request(query_params, :movie).url
    end

    test "generated URL is correct with query params and no media type", %{
      query_params: query_params
    } do
      expected_uri =
        URI.parse(
          "https://api.themoviedb.org/3/search/multi?query=avatar&language=en-UK&include_adult=true"
        )

      assert expected_uri == Tmdb.build_request(query_params, nil).url
    end

    test "generated URL is correct with query params and tv show media type", %{
      query_params: query_params
    } do
      assert URI.parse(
               "https://api.themoviedb.org/3/search/tv?query=avatar&language=en-UK&include_adult=true"
             ) == Tmdb.build_request(query_params, :show).url
    end

    test "generated headers are correct", %{
      query_params: query_params
    } do
      assert headers:
               %{
                 "Authorization" => ["Bearer 199**"],
                 "accept" => ["application/json"]
               } == Tmdb.build_request(query_params, :movie).headers
    end
  end

  describe "making requests" do
    test ":ok on 200", %{
      request_body: request_body,
      mock_mod: mock_mod
    } do
      expect(MockFetcher, :make_request, fn _req_obj -> {:ok, %{body: "response"}} end)
      assert mock_mod.make_request(request_body) == {:ok, %{body: "response"}}
    end

    test "not found error", %{
      mock_mod: mock_mod,
      request_body: request_body
    } do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, :not_found} end)
      assert mock_mod.make_request(request_body) == {:error, :not_found}
    end

    test "server error", %{
      mock_mod: mock_mod,
      request_body: request_body
    } do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, :server_error} end)
      assert mock_mod.make_request(request_body) == {:error, :server_error}
    end

    test "unauthorised error", %{
      mock_mod: mock_mod,
      request_body: request_body
    } do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, :unauthorised} end)
      assert mock_mod.make_request(request_body) == {:error, :unauthorised}
    end

    test "other error", %{
      mock_mod: mock_mod,
      request_body: request_body
    } do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, 422} end)
      assert mock_mod.make_request(request_body) == {:error, 422}
    end
  end
end
