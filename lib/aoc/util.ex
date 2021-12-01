defmodule AOC.Util do
  def load(day) do
    url = "https://adventofcode.com/2021/day/#{day}/input"
    response = HTTPoison.get!(url, [{"Cookie", Application.get_env(:aoc, :cookie)}])

    response.body
    |> String.trim()
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def load_integers(day) do
    load(day)
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
  end
end
