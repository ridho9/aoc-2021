defmodule Solver.Day6 do
  def solve(input, day) do
    Enum.reduce(1..day, input, fn _, acc -> advance_day(acc) end)
    |> Enum.sum()
  end

  def advance_day([day0 | rest]), do: List.update_at(rest, 6, &(&1 + day0)) ++ [day0]

  def solve_tuple(input, day) do
    Enum.reduce(1..day, List.to_tuple(input), fn d, acc ->
      advance_day_tuple(d, acc)
    end)
    |> Tuple.sum()
  end

  def advance_day_tuple(_, state) do
    {a0, a1, a2, a3, a4, a5, a6, a7, a8} = state
    {a1, a2, a3, a4, a5, a6, a7 + a0, a8, a0}
  end

  def parse(raw) do
    parsed =
      String.split(raw, ",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    for(
      i <- 0..8,
      do: Map.get(parsed, i, 0)
    )
  end
end
