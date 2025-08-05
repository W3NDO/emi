defmodule EmiCore.Scanner.Scanner do
  alias EmiCore.Media.Media

  @spec get_dir_entries(Path.t()) :: list()
  def get_dir_entries(dir) do
    Path.wildcard(Path.join([dir, "**", "*"]))
    |> Enum.filter(&File.regular?/1)
  end

  def build_media_structs(path) do
    name = Path.basename(path)
    path = Path.expand(path)
    type = Path.extname(path)
    size = File.stat!(path).size

    Media.new(name, path, type, size)
  end
end
