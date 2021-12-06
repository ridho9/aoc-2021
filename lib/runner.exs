# raw = File.read!("./inputs/day5_bigboy")
# input = Solver.Day5.parse(raw)

example_input = "3,4,3,1,2" |> Solver.Day6.parse()
input = AOC.Util.load_raw(6) |> Solver.Day6.parse()

# IO.inspect(Solver.Day6.solve(input, 80), label: "p1")
# IO.inspect(Solver.Day6.solve(input, 256), label: "p2")
# IO.inspect(Solver.Day6.solve(input, 18), label: "normal")
# IO.inspect(Solver.Day6.solve_tuple(input, 18), label: "tuple")
# IO.inspect(Solver.Day5.solve(input, true), label: "p2")
# Solver.Day6.solve_tuple(example_input, 9_999_999)
# |> IO.inspect()

Benchee.run(%{
  # "normal" => fn -> Solver.Day6.solve(input, 256) end,
  "big" => fn -> Solver.Day6.solve_tuple(example_input, 9_999_999) end
  # "tuple" => fn -> Solver.Day6.solve_tuple(input, 256) end
  # "p1 map" => fn -> Solver.Day5.solvemap(input, false) end,
  # "p2 map" => fn -> Solver.Day5.solvemap(input, true) end,
})
