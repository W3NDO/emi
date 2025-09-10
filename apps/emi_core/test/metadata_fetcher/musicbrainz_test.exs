defmodule MetadataFetcher.MusicbrainzTest do
  import Mox
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Musicbrainz
  alias EmiCore.MetadataFetcher.MockFetcher

  setup do
    :verify_on_exit!
    mock_mod = Application.get_env(:emi_core, :make_request)
    req = Musicbrainz.build_request(%{query: "Nura Habib Omer"}, :artist)

    {:ok, mock_mod: mock_mod, req: req}
  end

  describe "Creating a new request object " do
    test "Build a request for an artist" do
      expected_uri = "http://musicbrainz.org/ws/2/artist/?limit=1&query=Nura+Habib+Omer&fmt=json"

      query_params = %{
        query: "Nura Habib Omer"
      }

      assert expected_uri = Musicbrainz.build_request(query_params, :artist).url
    end

    test "Build a request for a recording " do
      expected_uri =
        "http://musicbrainz.org/ws/2/recording/?limit=1&query=Von+Party+Zu+Party&fmt=json"

      query_params = %{
        query: "Nura Habib Omer"
      }

      assert expected_uri = Musicbrainz.build_request(query_params, :recording)
    end
  end

  describe "Making a Request" do
    test "Successful request. {:200, :ok}", %{mock_mod: mock_mod, req: req} do
      expect(MockFetcher, :make_request, fn _req_obj -> {:ok, %{body: "Response"}} end)

      assert mock_mod.make_request(req) == {:ok, %{body: "Response"}}
    end

    test "Not found error, {:404, :not_found}", %{mock_mod: mock_mod, req: req} do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, :not_found} end)

      assert mock_mod.make_request(req) == {:error, :not_found}
    end

    test "server error, {:500, :server_error}", %{mock_mod: mock_mod, req: req} do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, :server_error} end)

      assert mock_mod.make_request(req) == {:error, :server_error}
    end

    test "Other errors, {:error, _}", %{mock_mod: mock_mod, req: req} do
      expect(MockFetcher, :make_request, fn _req_obj -> {:error, 422} end)

      assert mock_mod.make_request(req) == {:error, 422}
    end
  end
end
