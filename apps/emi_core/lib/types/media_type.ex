defmodule Types.MediaType do
  @behaviour MediaBeaviour
  @typedoc """
  This is a struct that will specify the type info about media. Should probably become a behaviour implementation.

  The media struct will hold information about a piece of media. For instance, a season of a TV Show will count as media. the path will thus be the path to the path of the season.

  the type field will be one of [:movie, :show, :music, :season, :album]

  is_dir is a boolean flag that indicates whether it is a directory and needs to be cataloged further.

  name is the top level name of the dir (if it is a directory,) or file if it is not a directory.

  an example would be ::
      %FileScanner.Media{
        path: "path/avatar.mp4",
        type: :movie,
        is_dir: false,
        name: "Avatar (2012)"
        allowed_types: [:mov, :avi, :mkv, :mp4],
        format: :mp4
      }
  """

  @type t :: %__MODULE__{
          path: String.t() | Path.t(),
          type: nil | :movie | :show | :episode | :album | :song,
          is_dir: boolean(),
          name: String.t() | nil,
          format: nil | :mp4 | :mov | :avi | :mkv | :mp3 | :flac | :aac,
          allowed_formats: list(atom)
        }

  defstruct path: "",
            type: nil,
            is_dir: false,
            name: nil,
            format: nil,
            allowed_formats: nil

  @impl MediaBehaviour
  def allowed_formats(%Types.MediaType{type: type}) do
    formats_for(type)
  end

  defp formats_for(:movie), do: {:ok, [:mp4, :mov, :avi, :mkv]}
  defp formats_for(:episode), do: {:ok, [:mp4, :mov, :avi, :mkv]}
  defp formats_for(:show), do: {:ok, [:mp4, :mov, :avi, :mkv]}
  defp formats_for(:album), do: {:ok, [:mp3, :flac, :aac]}
  defp formats_for(_), do: {:error, :unsupported_format}
end
