defmodule Day3.GearRatios.Part1 do
  def run do
    import Input

    result =
      "input_p1.txt"
      |> read_input_file(day: 3)
      |> collect_numbers()
      |> Enum.sum()

    # |> Stream.map(&sum_line/1)
    # |> Enum.sum()

    result
  end

  def collect_numbers(lines) do
    nums = numbers(lines)
    symbols = symbol_positions(lines)

    nums
    |> Stream.filter(fn {rows, cols, _} ->
      for i <- rows,
          j <- cols,
          reduce: false,
          do: (acc -> acc || {i, j} in symbols)
    end)
    |> Stream.map(&elem(&1, 2))
  end

  def numbers(lines) do
    lines
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.map(fn {line, i} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, len} ->
        {(i - 1)..(i + 1), (j - 1)..(j + len), String.to_integer(String.slice(line, j, len))}
      end)
    end)
    |> List.flatten()
  end

  def symbol_positions(lines) do
    lines
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/[^a-zA-Z0-9\.]/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
  end
end

defmodule Day3.GearRatios.Part2 do
  alias Day3.GearRatios.Part1

  def run do
    import Input

    result =
      "input_p1.txt"
      |> read_input_file(day: 3)
      |> collect_numbers()
      |> Enum.sum()

    # |> Stream.map(&sum_line/1)
    # |> Enum.sum()

    result
  end

  def collect_numbers(lines) do
    nums = Part1.numbers(lines)

    lines
    |> symbol_positions()
    |> Stream.map(fn {i, j} ->
      case Enum.filter(nums, fn {rows, cols, _n} -> i in rows and j in cols end) do
        [a, b] -> elem(a, 2) * elem(b, 2)
        _ -> 0
      end
    end)
  end

  def symbol_positions(lines) do
    lines
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/\*/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
  end
end
