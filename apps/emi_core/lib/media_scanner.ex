defmodule MediaScanner do
  def get_dir_entries(dir) do
    Path.wildcard(Path.join([dir, "**", "*"]))
    |> Enum.filter(&File.regular?/1)
  end
end
