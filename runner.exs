# raw = File.read!("./inputs/day5_bigboy")
# input = Solver.Day5.parse(raw)

# input = Solver.Day6.example_raw() |> Solver.Day6.parse()
input = AOC.Util.load_raw(6) |> Solver.Day6.parse()

IO.inspect(Solver.Day6.solve(input, 80), label: "p1")
IO.inspect(Solver.Day6.solve(input, 256), label: "p2")
# IO.inspect(Solver.Day5.solve(input, true), label: "p2")


# Benchee.run(%{
#   "p1 list" => fn -> Solver.Day5.solve(input, false) end,
#   "p2 list" => fn -> Solver.Day5.solve(input, true) end,
#   # "p1 map" => fn -> Solver.Day5.solvemap(input, false) end,
#   # "p2 map" => fn -> Solver.Day5.solvemap(input, true) end,
# })
