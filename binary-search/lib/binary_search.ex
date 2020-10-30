defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    list = Tuple.to_list(numbers)
    list_length = Kernel.length(list)

    search(list, key, 0, list_length)
  end

  defp search(list, key, initial, final) do
    middle = Kernel.div(initial+final, 2)
    middle_number = Enum.at(list, middle)
    cond do
      (initial == final) && (middle_number != key) -> :not_found
      middle_number == key -> {:ok, middle}
      middle_number > key -> search(list, key, initial, middle - 1)
      true -> search(list, key, middle + 1, final)
    end
  end
end
