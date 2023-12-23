defmodule Day1.Trebuchet.Part1 do
  def sum do
    import Input

    result =
      "aoc_input.txt"
      |> read_input_file(day: 1)
      |> Enum.reduce(0, fn line, acc ->
        acc + find_number(line)
      end)

    result
  end

  def find_number(line) do
    String.to_integer("#{first_number(line)}#{last_number(line)}")
  end

  def first_number(line) do
    find_number_inline(line)
  end

  def last_number(line) do
    rline = String.reverse(line)
    find_number_inline(rline)
  end

  # part 1
  defp find_number_inline(""), do: raise("not found any number")
  defp find_number_inline(<<n, _rest::bitstring>>) when n in ?1..?9, do: n - ?0
  defp find_number_inline(<<_n, rest::bitstring>>), do: find_number_inline(rest)
end

defmodule Day1.Trebuchet.Part2 do
  def hello do
    :world
  end

  @number_token [
    {"1", 1},
    {"2", 2},
    {"3", 3},
    {"4", 4},
    {"5", 5},
    {"6", 6},
    {"7", 7},
    {"8", 8},
    {"9", 9},
    {"one", 1},
    {"two", 2},
    {"three", 3},
    {"four", 4},
    {"five", 5},
    {"six", 6},
    {"seven", 7},
    {"eight", 8},
    {"nine", 9}
  ]

  def sum do
    import Input

    result =
      "input_p2.txt"
      |> read_input_file(day: 1)
      |> Enum.reduce(0, fn line, acc ->
        acc + String.to_integer("#{first_number(line)}#{last_number(line)}")
      end)

    result
  end

  def first_number(line) do
    {_n_pos, n_value} =
      line
      |> find_number(@number_token, direction: :first)
      |> Enum.min_by(fn {pos, _} -> pos end)

    n_value
  end

  def last_number(line) do
    {_n_pos, n_value} =
      line
      |> find_number(@number_token, direction: :last)
      |> Enum.max_by(fn {pos, _} -> pos end)

    n_value
  end

  def find_number(_line, [], _direction), do: {0, 0}

  def find_number(line, token, direction) do
    {start, step} =
      case direction do
        [{:direction, :first} | _] -> {0, 1}
        [{:direction, :last} | _] -> {-1, -1}
      end

    numbers =
      token
      |> Enum.reduce([], fn sn, acc ->
        match = find_number_inline(line, sn, start, step)

        if match != nil do
          [match | acc]
        else
          acc
        end
      end)

    numbers
  end

  defp find_number_inline(line, {s, v} = sn, pos, step) do
    line_len = String.length(line)

    case String.slice(line, pos, String.length(s)) do
      "" -> nil
      ^s -> {pos, v}
      _ when line_len - pos * step < 0 -> nil
      _ -> find_number_inline(line, sn, pos + step, step)
    end
  end
end
