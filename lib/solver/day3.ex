defmodule Solver.Day3 do
  def part1 do
    input = AOC.Util.load(3)
    gamma = solver1(input, &filter_max/1)
    epsilon = solver1(input, &filter_min/1)
    {gamma, epsilon, gamma * epsilon}
  end

  def part2 do
    input = AOC.Util.load(3)
    oxy = solver2(input, 0, &filter_max/1)
    scr = solver2(input, 0, &filter_min/1)
    {oxy, scr, oxy * scr}
  end

  def filter_max(%{?1 => a, ?0 => b}), do: if(a >= b, do: "1", else: "0")
  def filter_min(%{?1 => a, ?0 => b}), do: if(a < b, do: "1", else: "0")

  def map_digit(digit, filter), do: digit |> Enum.frequencies() |> filter.()

  def solver1(input, filter) do
    input
    |> transpose()
    |> Enum.map_join(&map_digit(&1, filter))
    |> parsebin
  end

  def solver2([result], _, _), do: parsebin(result)

  def solver2(input, idx, filter) do
    filter_c =
      input
      |> transpose()
      |> Enum.at(idx)
      |> map_digit(filter)

    Enum.filter(input, &(String.at(&1, idx) == filter_c))
    |> solver2(idx + 1, filter)
  end

  def parsebin(l), do: Integer.parse(l, 2) |> elem(0)

  def transpose(input) do
    input
    |> Enum.map(&String.to_charlist/1)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
