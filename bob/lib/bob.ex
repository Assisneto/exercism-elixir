defmodule Bob do
  def hey(input) do
    cond do
      yell(input) && ask(input) -> "Calm down, I know what I'm doing!"

      ask(input) -> "Sure."

      yell(input) -> "Whoa, chill out!"

      is_alnum(input) -> "Whatever."

      true -> "Fine. Be that way!"
    end
  end

  defp ends_with(input,alnum) do
    String.trim(input)
      |>String.ends_with?(alnum)
  end

  defp yell(input) do
    String.match?(input,~r/\p{Lu}{4,}/u) ||
    String.match?(input,~r/\p{Lu}{2,}/u) &&
    ends_with(input,"!")
  end

  defp is_alnum(input) do
    String.match?(input,~R/[[:alnum:]]/)
  end

  defp ask(input) do
    ends_with(input,"?")
  end
end
