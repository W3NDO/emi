defmodule MediaBehaviour do

  @doc """
  lists allowed file types for this media type.
  """
  @callback allowed_formats(Types.Media.t()) :: {:ok, list} | {:error, atom}

  @doc """
  Lists the name of the media
  """
  @callback get_name(Types.Media.t()) :: {:ok, String.t() | {:error, atom}}

  @doc """
  List the metadata of a piece of media
  """

  @callback get_metadata(Types.Media.t()) :: {:ok, map} | {:error, atom}
end
