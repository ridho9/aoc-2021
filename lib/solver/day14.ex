defmodule Solver.Day14 do
  def p1(input, step) do
    {template, mapping} = input

    Enum.reduce(1..step, template, fn _gen, template ->
      step(template, mapping)
    end)
    |> score()
  end

  def step(template, mapping) do
    Enum.reduce(template, %{}, fn {pair, count}, acc ->
      case Map.get(mapping, pair) do
        nil -> [{pair, count}]
        respair -> Enum.map(respair, &{&1, count})
      end
      |> Enum.reduce(acc, fn {p, c}, acc -> Map.update(acc, p, c, &(&1 + c)) end)
    end)
  end

  def score(template) do
    Enum.reduce(template, %{}, fn {k, v}, acc ->
      Map.update(acc, String.at(k, 0), v, &(&1 + v))
    end)
    |> Enum.reduce([], fn {_k, v}, acc -> [v | acc] end)
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def parse(raw) do
    [template, "" | mapping] = String.split(raw, "\n")

    template =
      String.to_charlist(template <> "1")
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(&to_string/1)
      |> Enum.frequencies()

    mapping =
      Enum.map(mapping, fn l ->
        [bef, aft] = String.split(l, " -> ")
        {bef, [String.at(bef, 0) <> aft, aft <> String.at(bef, 1)]}
      end)
      |> Map.new()

    {template, mapping}
  end
end
