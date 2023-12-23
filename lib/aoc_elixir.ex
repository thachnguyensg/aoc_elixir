defmodule AocElixir do
  @moduledoc """
  Documentation for `AocElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AocElixir.hello()
      :world

  """
  def hello do
    :world
  end

  def day1_part1 do
    Day1.Trebuchet.Part1.sum()
  end

  def day1_part2 do
    Day1.Trebuchet.Part2.sum()
  end
end
