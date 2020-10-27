
defmodule Bob do
  @spec hey(input :: String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      silence?(input) -> "Fine. Be that way!"
      forceful_question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input), do: input == ""

  defp question?(input), do: String.ends_with?(input, "?")

  defp shouting?(input) do
    String.upcase(input) == input and String.downcase(input) != input
  end

  defp forceful_question?(input) do
    question?(input) and shouting?(input)
  end
end
