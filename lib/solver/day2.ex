defmodule Solver.Day2 do
  def part1, do: solve(&solver1/2)
  def part2, do: solve(&solver2/2)

  def solve(solver) do
    AOC.Util.load(2)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [a, b] -> [a, String.to_integer(b)] end)
    |> Enum.reduce({0, 0, 0}, solver)
    |> then(fn {a, b, _} -> a * b end)
  end

  def solver1(["forward", x], {hor, depth, aim}), do: {hor + x, depth, aim}
  def solver1(["down", x], {hor, depth, aim}), do: {hor, depth + x, aim}
  def solver1(["up", x], {hor, depth, aim}), do: {hor, depth - x, aim}

  def solver2(["forward", x], {hor, depth, aim}), do: {hor + x, depth + aim * x, aim}
  def solver2(["down", x], {hor, depth, aim}), do: {hor, depth, aim + x}
  def solver2(["up", x], {hor, depth, aim}), do: {hor, depth, aim - x}
end
