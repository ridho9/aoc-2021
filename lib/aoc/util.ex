defmodule AOC.Util do
  def load(day) do
    {:ok, dets} = :dets.open_file(:"storage.dets", [{:type, :set}])

    res =
      case :dets.lookup(dets, day) do
        [] ->
          url = "https://adventofcode.com/2021/day/#{day}/input"
          response = HTTPoison.get!(url, [{"Cookie", Application.get_env(:aoc, :cookie)}])

          result =
            response.body
            |> String.trim()
            |> String.split("\n")
            |> Enum.filter(&(&1 != ""))

          :dets.insert(dets, {day, result})
          result

        [{_, res}] ->
          res
      end

    :dets.close(dets)
    res
  end

  def load_integers(day) do
    load(day)
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
  end
end
