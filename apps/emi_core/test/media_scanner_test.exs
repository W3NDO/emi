defmodule MediaScannerTest do
  use ExUnit.Case, async: true

  describe "get_dir_entries/1" do
    # create a temporary directory to be used within this test (https://hexdocs.pm/ex_unit/1.12/ExUnit.Case.html#module-tmp-dir)
    @describetag :tmp_dir

    test "lists all files in given directory.", %{tmp_dir: dir} do
      # write a file
      dir |> Path.join("avatar.mp4") |> File.write("Hola")
      dir |> Path.join("Pacific Rim.mp4") |> File.write("Aloha?")
      entries = MediaScanner.get_dir_entries(dir)

      assert true == File.exists?(Path.join(dir, "avatar.mp4"))
      paths = ["#{Path.expand(dir)}/avatar.mp4", "#{Path.expand(dir)}/Pacific Rim.mp4"]
      assert Enum.all?(paths, fn entry -> Enum.member?(paths, entry) end) == true
    end

    test "Returns empty array when no files exist", %{tmp_dir: dir} do
      entries = MediaScanner.get_dir_entries(dir)
      assert [] == entries
    end
  end
end
