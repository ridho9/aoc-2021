defmodule Solver.Day1 do
  def part1 do
    AOC.Util.load_integers(1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [a, b] -> b > a end)
    |> length()
  end

  def part2 do
    AOC.Util.load_integers(1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [a, b] -> b > a end)
    |> length()
  end
end
