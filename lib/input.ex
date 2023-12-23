defmodule Input do
  def read_input_file(file_path, day \\ []) do
    path =
      case day do
        [day: d] -> "#{__DIR__}/day#{d}/#{file_path}"
        _ -> "#{__DIR__}/#{file_path}"
      end

    # IO.inspect(path)
    read_file(path)
  end

  def read_file(file_path) do
    file_path
    |> File.stream!()

    # |> Enum.map(&IO.puts/1)
  end
end
