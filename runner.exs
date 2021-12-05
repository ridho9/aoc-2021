# raw = File.read!("./inputs/day5_bigboy")
# input = Solver.Day5.parse(raw)

input = Solver.Day5.load()

IO.inspect(Solver.Day5.solve(input, false), label: "p1")
IO.inspect(Solver.Day5.solve(input, true), label: "p2")


# Benchee.run(%{
#   "p1 list" => fn -> Solver.Day5.solve(input, false) end,
#   "p2 list" => fn -> Solver.Day5.solve(input, true) end,
#   # "p1 map" => fn -> Solver.Day5.solvemap(input, false) end,
#   # "p2 map" => fn -> Solver.Day5.solvemap(input, true) end,
# })
