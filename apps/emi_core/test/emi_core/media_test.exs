defmodule EmiCore.MediaTest do
  use ExUnit.Case, async: true

  describe "creating a new media struct" do
    @describetag :tmp_dir

    test "new/4", %{tmp_dir: dir} do
      assert %EmiCore.Media.Media{
               name: "avatar.mp4",
               path: "#{dir}/avatar.mp4",
               type: ".mp4",
               size: 0,
               tags: []
             } ==
               EmiCore.Media.Media.new("avatar.mp4", "#{Path.join(dir, "avatar.mp4")}", ".mp4", 0)
    end

    test "new/5", %{tmp_dir: dir} do
      assert %EmiCore.Media.Media{
               name: "avatar.mp4",
               path: "#{dir}/avatar.mp4",
               type: ".mp4",
               size: 0,
               tags: ["movie"]
             } ==
               EmiCore.Media.Media.new(
                 "avatar.mp4",
                 "#{Path.join(dir, "avatar.mp4")}",
                 ".mp4",
                 0,
                 ["movie"]
               )
    end
  end
end
