defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    to_roman(number)
  end

  @base_roman_number [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  defp to_roman(0), do: ""

  defp to_roman(number)do
    {roman_digit_value, roman_digit} = Enum.find(@base_roman_number, fn {roman_digit_value, _roman_digit} -> number >= roman_digit_value end)
    roman_digit <> to_roman(number - roman_digit_value)
  end

end
