defmodule Day2.CubeConundrum.Part1 do
  @set_rule %{"red" => 12, "green" => 13, "blue" => 14}

  def run do
    import Input

    result =
      "input_p1.txt"
      |> read_input_file(day: 2)
      |> Enum.reduce(0, fn line, acc ->
        case check_game(line) do
          {:yes, id} -> acc + id
          _ -> acc
        end
      end)

    result
  end

  def check_game(line) do
    [header | bag] = String.split(line, ":")
    IO.puts("")
    IO.puts("#{inspect(header)}")

    if check_bag(bag) == true do
      {:yes, get_game_id(header)}
    else
      :no
    end
  end

  def get_game_id(header) do
    header
    |> String.split(":")
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.at(1)
    |> String.to_integer()
  end

  def check_bag([bag]) do
    IO.inspect(bag)

    result =
      bag
      |> String.trim_trailing("\n")
      |> String.split(";")
      |> Enum.all?(&check_set/1)

    result
  end

  def check_set(set) do
    result =
      set
      |> String.split(",")
      |> Stream.map(&String.trim/1)
      |> Enum.all?(fn cube ->
        [number, type] = String.split(cube, " ")
        IO.puts("#{type}: #{number} matching #{@set_rule[type]}")
        String.to_integer(number) <= @set_rule[type]
      end)

    IO.puts("-----#{result}")
    result
  end
end

defmodule Day2.CubeConundrum.Part2 do
  def run do
    import Input

    result =
      "input_p2.txt"
      |> read_input_file(day: 2)
      |> Enum.reduce(0, fn line, acc ->
        acc + game_power(line)
      end)

    result
  end

  def game_power(game) do
    game
    |> get_bag()
    |> get_max_set(%{})
    |> IO.inspect()
    |> power()
  end

  def get_bag(game) when is_binary(game) do
    game
    |> String.trim_trailing("\n")
    |> String.split(":")
    |> Enum.at(1)
    |> String.split(";")
  end

  def get_max_set([], max_set), do: max_set

  def get_max_set([set | rest], max_set) do
    get_max_set(rest, Map.merge(max_set, to_map(set), fn _k, v1, v2 -> max(v1, v2) end))
  end

  def to_map(set) do
    set
    |> String.split(",")
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(%{}, fn cube, map ->
      [number, type] = String.split(cube, " ")
      Map.put_new(map, type, String.to_integer(number))
    end)
  end

  def power(%{"red" => red, "green" => green, "blue" => blue}) do
    red * green * blue
  end
end
