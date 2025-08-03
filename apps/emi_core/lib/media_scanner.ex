defmodule MediaScanner do
  defp directory_exists?(path) do
    case File.dir?(path) do
      true -> {:ok, path}
      false -> {:error, "Directory does not exist"}
    end
  end

  @spec get_dir_entries(Path.t()) :: list()
  def get_dir_entries(path) do
    {:ok, entries} =
      if {:ok, path} = directory_exists?(path) do
        {:ok, _entries} = File.ls(path)
      else
        {:error, "Directory does not exist."}
      end

    Enum.map(entries, fn entry ->
      is_dir = "#{path}/#{entry}" |> Path.expand() |> File.dir?()
      [entry, is_dir]
    end)
  end
end
