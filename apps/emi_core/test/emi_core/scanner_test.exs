defmodule EmiCore.ScannerTest do
  use ExUnit.Case, async: true
  alias EmiCore.Scanner.Scanner

  describe "get_dir_entries/1" do
    # create a temporary directory to be used within this test (https://hexdocs.pm/ex_unit/1.12/ExUnit.Case.html#module-tmp-dir)
    @describetag :tmp_dir

    test "lists all files in given directory.", %{tmp_dir: dir} do
      # write a file
      dir |> Path.join("avatar.mp4") |> File.write("Hola")
      dir |> Path.join("Pacific Rim.mp4") |> File.write("Aloha?")
      entries = Scanner.get_dir_entries(dir)

      assert true == File.exists?(Path.join(dir, "avatar.mp4"))
      paths = ["#{Path.expand(dir)}/avatar.mp4", "#{Path.expand(dir)}/Pacific Rim.mp4"]
      assert Enum.all?(paths, fn entry -> Enum.member?(paths, entry) end) == true
    end

    test "Returns empty array when no files exist", %{tmp_dir: dir} do
      entries = Scanner.get_dir_entries(dir)
      assert [] == entries
    end
  end

  ## This test is flaky. We need to find a way to refactr it.
  describe "Build media structs" do
    @describetag :tmp_dir

    test "returns accepts a path and builds a struct of type media", %{tmp_dir: dir} do
      dir |> Path.join("avatar.mp4") |> File.write("Hola")
      dir |> Path.join("Pacific Rim.mp4") |> File.write("Aloha?")
      entries = Scanner.get_dir_entries(dir)

      media_structs = Enum.map(entries, fn path -> Scanner.build_media_structs(path) end)

      expected_media_names_paths = [
        %{
          name: "avatar",
          path: "#{dir}/avatar.mp4"
        },
        %{
          name: "Pacific Rim",
          path: "#{dir}/Pacific Rim.mp4"
        }
      ]

      received_media_names_paths =
        Enum.map(media_structs, fn struct -> %{name: struct.name, path: struct.path} end)

      assert Enum.all?(expected_media_names_paths, fn struct ->
               Enum.member?(received_media_names_paths, struct)
             end) == true
    end
  end
end
