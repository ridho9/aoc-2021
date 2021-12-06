defmodule Solver.Day6 do
  def solve(input, day) do
    Enum.reduce(1..day, input, fn _, acc -> advance_day(acc) end)
    |> Enum.sum()
  end

  def advance_day([day0 | rest]), do: List.update_at(rest, 6, &(&1 + day0)) ++ [day0]

  def parse(raw) do
    parsed =
      String.split(raw, ",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    for i <- 0..8, do: Map.get(parsed, i, 0)
  end
end
