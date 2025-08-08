defmodule MetadataFetcher.MusicbrainzTest do
  use ExUnit.Case, async: true
  alias EmiCore.MetadataFetcher.Musicbrainz

  describe "Creating a new request object " do
    test "Build a request for an artist" do
      expected_uri = "http://musicbrainz.org/ws/2/artist/?limit=1&query=Nura+Habib+Omer&fmt=json"

      query_params = %{
        query: "Nura Habib Omer"
      }

      assert expected_uri = Musicbrainz.build_request(query_params, :artist).url
    end

    test "Build a request for a recording " do
      expected_uri = "http://musicbrainz.org/ws/2/recording/?limit=1&query=Von+Party+Zu+Party&fmt=json"

      query_params = %{
        query: "Nura Habib Omer"
      }

      assert expected_uri = Musicbrainz.build_request(query_params, :recording )
    end
  end
end
