defmodule Solver.Day5 do
  def solve(input, diagonal) do
    input
    |> Enum.reduce([], fn
      [{x, y1}, {x, y2}], acc ->
        {y_start, y_end} = Enum.min_max([y1, y2])
        Enum.reduce(y_start..y_end, acc, fn y, acc -> [{x, y} | acc] end)

      [{x1, y}, {x2, y}], acc ->
        {x_start, x_end} = Enum.min_max([x1, x2])
        Enum.reduce(x_start..x_end, acc, fn x, acc -> [{x, y} | acc] end)

      [{x1, y1}, {x2, y2}], acc ->
        if diagonal do
          [{x1, y1}, {_x2, y2}] = if x2 < x1, do: [{x2, y2}, {x1, y1}], else: [{x1, y1}, {x2, y2}]
          xdiff = y2 - y1
          xrange = if xdiff >= 0, do: 0..xdiff, else: xdiff..0
          Enum.reduce(xrange, acc, fn i, acc -> [{x1 + abs(i), y1 + i} | acc] end)
        else
          acc
        end
    end)
    |> Enum.frequencies()
    |> Enum.count(fn {_, v} -> v >= 2 end)
  end

  def solve2(input, diagonal) do
    input
    |> Enum.reduce([], fn
      [{x, y1}, {x, y2}], acc ->
        {y_start, y_end} = Enum.min_max([y1, y2])

        Enum.reduce(y_start..y_end, acc, fn y, acc ->
          [{x, y} | acc]
        end)

      [{x1, y}, {x2, y}], acc ->
        {x_start, x_end} = Enum.min_max([x1, x2])

        Enum.reduce(x_start..x_end, acc, fn x, acc ->
          [{x, y} | acc]
        end)

      [{x1, y1}, {x2, y2}], acc ->
        if diagonal do
          [{x1, y1}, {_x2, y2}] = if x2 < x1, do: [{x2, y2}, {x1, y1}], else: [{x1, y1}, {x2, y2}]
          xdiff = y2 - y1
          xrange = if xdiff >= 0, do: 0..xdiff, else: xdiff..0

          Enum.reduce(xrange, acc, fn i, acc ->
            [{x1 + abs(i), y1 + i} | acc]
          end)
        else
          acc
        end
    end)
    |> Enum.frequencies()
    |> Enum.count(fn {_, v} -> v >= 2 end)
  end

  def load, do: AOC.Util.load_raw(5) |> parse()

  def parse(raw) do
    String.trim(raw)
    |> String.split("\n")
    |> Enum.map(fn line ->
      [p_start, _, p_end] = String.split(line)

      [p_start, p_end]
      |> Enum.map(fn point_string ->
        String.split(point_string, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)
  end
end
