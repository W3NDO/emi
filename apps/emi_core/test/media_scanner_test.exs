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
      assert [["avatar.mp4", false], ["Pacific Rim.mp4", false]] == entries
    end

    test "Returns empty array when no files exist", %{tmp_dir: dir} do
      entries = MediaScanner.get_dir_entries(dir)
      assert [] == entries
    end

    test "Lists all folders in the directory", %{tmp_dir: dir} do
      new_subfolder = File.mkdir(Path.join(dir, "sub1"))

      entries = MediaScanner.get_dir_entries(dir)

      assert [["sub1", true]] == entries
    end

    test "Fails if no folders are present in the directory", %{tmp_dir: dir} do
      entries = MediaScanner.get_dir_entries(dir)
      assert [] == entries
    end
  end

  describe "get entry subdirectories" do
    @describetag :tmp_dir

    test "get a data structure listing all entries and their files or sub dirs" do
    end
  end
end
