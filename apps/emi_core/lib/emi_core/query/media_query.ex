defmodule EmiCore.Query.MediaQuery do
  alias EmiDb.{Repo, VisualMedia}
  alias EmiDb.AudioMedia
  # alias EmiCore.MetadataFetcher.Tmdb
  # alias EmiCore.MetadataFetcher.Musicbrainz

  @original_image_base_path "https://image.tmdb.org/t/p/original"
  # @width_500_image_base_path "https://image.tmdb.org/t/p/w500"
  @doc """
  The media specifier here refers to an atom specifying if it is visual or audio
  """
  @spec insert_to_repo(map, atom) :: {:ok, integer} | {:error, list}
  def insert_to_repo(response_body, media_specifier) do
    changeset =
      case media_specifier do
        :visual -> response_body |> format_visual_media_attrs |> create_changeset(media_specifier)
        :audio -> response_body |> format_audio_media_attrs |> create_changeset(media_specifier)
        _ -> {:ok, :bye}
      end

    Repo.insert(changeset)

    # TODO after this we need to trigger a background job to fetch the specific information about the media and update the data.
  end

  defp format_visual_media_attrs(media_attrs) do
    updated_media = media_attrs |> convert_keys_to_atoms()

    updated_media
    |> Map.update!(:release_date, fn _ ->
      to_utc_datetime!(updated_media.release_date)
    end)
    |> Map.update!(:backdrop_path, fn _ -> expand_paths(updated_media.backdrop_path) end)
    |> Map.update!(:poster_path, fn _ -> expand_paths(updated_media.poster_path) end)
    |> update_id_key(:tmdb)
  end

  defp convert_keys_to_atoms(attrs) do
    attrs
    |> Map.new(fn {k, v} -> if is_atom(k), do: {k, v}, else: {String.to_atom(k), v} end)
  end

  defp format_audio_media_attrs(media_attrs) do
  end

  defp create_changeset(attrs, model) do
    case model do
      :visual -> VisualMedia.changeset(%VisualMedia{}, attrs)
      :audio -> AudioMedia.changeset(%AudioMedia{}, attrs)
      _ -> {:ok, :bye}
    end
  end

  defp to_utc_datetime!(date_string) do
    {:ok, datetime, _} = DateTime.from_iso8601("#{date_string}T00:00:00Z")
    datetime
  end

  defp expand_paths(path) do
    @original_image_base_path <> path
  end

  defp update_id_key(attr_map, source) do
    case source do
      :tmdb -> Map.put_new(attr_map, :tmdb_id, "#{attr_map.id}")
      _ -> {:ok, :bye}
    end
  end
end
