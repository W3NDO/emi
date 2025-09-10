defmodule EmiCore.Media.Media do
  @type t :: %__MODULE__{
          name: String.t(),
          path: Path.t(),
          type: atom(),
          size: integer,
          tags: list
        }

  defstruct name: "",
            path: nil,
            type: nil,
            size: 0,
            tags: []

  @spec new(String.t(), Path.t(), binary(), integer) :: t()
  def new(name, path, type, size) do
    new(name, path, type, size, [])
  end

  def new(name, path, type, size, tags) do
    %__MODULE__{
      name: name,
      path: path,
      type: type,
      size: size,
      tags: tags
    }
  end
end
