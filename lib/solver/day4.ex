defmodule Solver.Day4 do
  def part1 do
    {pulls, boards} = load()

    pulls
    |> Enum.reduce({boards, 0}, fn
      pull, {boards, 0} ->
        mark_score_board(boards, pull)
        |> Enum.reduce({[], 0}, fn {board, score}, {acc_board, max_score} ->
          {[board | acc_board], Enum.max([score, max_score])}
        end)

      _pull, {boards, score} ->
        {boards, score}
    end)
    |> elem(1)
  end

  def part2 do
    {pulls, boards} = load()

    pulls
    |> Enum.reduce({boards, 0}, fn
      _pull, {[], score} ->
        {[], score}

      pull, {boards, _score} ->
        score = mark_score_board(boards, pull)

        case Enum.filter(score, &(elem(&1, 1) == 0)) do
          [] ->
            [{_, score}] = score
            {[], score}

          board_filtered ->
            List.zip(board_filtered)
            |> Enum.at(0)
            |> Tuple.to_list()
            |> then(fn boards -> {boards, score} end)
        end
    end)
    |> elem(1)
  end

  def mark_score_board(boards, pull) do
    Enum.map(boards, &mark_board(&1, pull))
    |> Enum.map(&{&1, score_if_win(&1, pull)})
  end

  def mark_board(board, num), do: Enum.map(board, &mark_row(&1, num))
  def mark_row(row, curnum), do: Enum.map(row, fn {num, mark} -> {num, num == curnum || mark} end)

  def row_board_win?(board), do: Enum.reduce(board, false, &(row_win?(&1) || &2))
  def row_win?(row), do: Enum.reduce(row, true, fn {_, marked}, acc -> acc && marked end)

  def score_if_win(board, pull) do
    row_win? = row_board_win?(board)
    col_win? = transpose(board) |> row_board_win?()
    if row_win? || col_win?, do: count_score(board, pull), else: 0
  end

  def count_score(board, curnum), do: curnum * Enum.reduce(board, 0, &(count_row_score(&1) + &2))

  def count_row_score(row),
    do: Enum.reduce(row, 0, fn {n, mark?}, acc -> acc + if mark?, do: 0, else: n end)

  def transpose(board), do: Enum.zip(board) |> Enum.map(&Tuple.to_list/1)

  def rows_to_boards(rows) do
    Enum.map(rows, fn row ->
      String.split(row)
      |> Enum.map(&{String.to_integer(&1), false})
    end)
    |> Enum.chunk_every(5)
  end

  def load do
    [pulls | rows] = AOC.Util.load(4)
    boards = rows_to_boards(rows)
    pulls = String.split(pulls, ",") |> Enum.map(&String.to_integer/1)
    {pulls, boards}
  end
end
