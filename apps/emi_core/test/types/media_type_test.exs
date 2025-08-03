defmodule Types.MediaTypeTest do
  alias Types.MediaType
  use ExUnit.Case, async: true

  describe "Generating a struct of type media" do
    test "Build a valid struct" do
    end

    @tag :skip
    test "Ensures that a media type can only be one of nil | :movie | :show | :episode | :album | :song",
         %{tmp_dir: dir} do
      _invalid_media = %MediaType{
        path: Path.join(dir, "Avatar.mp4"),
        type: :long_movie,
        is_dir: false,
        name: "Avatar"
      }

      assert raise Error
    end
  end
end
