defmodule Solver.Day16 do
  def parse_single(<<ver::size(3), id::size(3), load::bitstring>>) do
    {body, rest} = parse_load(id, load)
    {{ver, id, body}, rest}
  end

  def parse_n(load, 0), do: {[], load}

  def parse_n(load, n) do
    {msg, rest} = parse_single(load)
    {next, rest} = parse_n(rest, n - 1)
    {[msg | next], rest}
  end

  def parse_all(""), do: {[], ""}

  def parse_all(load) do
    {msg, rest} = parse_single(load)
    {next, rest} = parse_all(rest)
    {[msg | next], rest}
  end

  def parse_load(4, load) do
    {num, rest} = consume_number(load)
    lnum = bit_size(num)
    <<num::integer-size(lnum)>> = num
    {num, rest}
  end

  def parse_load(_, <<1::1, nsub::integer-size(11), rest::bits>>) do
    parse_n(rest, nsub)
  end

  def parse_load(_, <<0::1, lensub::integer-size(15), sub::bits-size(lensub), rest::bits>>) do
    {load, _} = parse_all(sub)
    {load, rest}
  end

  def consume_number(<<1::size(1), load::bits-size(4), rest::bits>>) do
    {next, rest} = consume_number(rest)
    {<<load::bits, next::bits>>, rest}
  end

  def consume_number(<<0::size(1), load::bits-size(4), rest::bits>>) do
    {load, rest}
  end

  def sumver(list) do
    Enum.reduce(list, 0, fn
      {ver, 4, _}, acc -> acc + ver
      {ver, _, b}, acc when is_list(b) -> acc + ver + sumver(b)
    end)
  end

  def p1(s) do
    Solver.Day16.parse_single(s)
    |> elem(0)
    |> (&sumver([&1])).()
  end

  def eval({_, 0, body}), do: Enum.map(body, &eval/1) |> Enum.sum()
  def eval({_, 1, body}), do: Enum.reduce(body, 1, fn b, x -> x * eval(b) end)
  def eval({_, 2, body}), do: Enum.map(body, &eval/1) |> Enum.min()
  def eval({_, 3, body}), do: Enum.map(body, &eval/1) |> Enum.max()
  def eval({_, 4, v}), do: v
  def eval({_, 5, body}), do: cmp(body, &Kernel.>/2)
  def eval({_, 6, body}), do: cmp(body, &Kernel.</2)
  def eval({_, 7, body}), do: cmp(body, &Kernel.==/2)

  def cmp(body, f) do
    [l, r] = Enum.map(body, &eval/1)
    if f.(l, r), do: 1, else: 0
  end

  def p2(s) do
    Solver.Day16.parse_single(s)
    |> elem(0)
    |> eval
  end
end
