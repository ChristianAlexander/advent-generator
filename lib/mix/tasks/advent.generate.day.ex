defmodule Mix.Tasks.Advent.Generate.Day do
  use Igniter.Mix.Task

  @example "mix advent.generate.day 1 2024"

  @shortdoc "Generates scaffold for an advent of code solution"
  @moduledoc """
  #{@shortdoc}

  ## Example

  ```bash
  #{@example}
  ```

  ## Options

  * [day] The day of the month to generate. Defaults to the current day in the Eastern time zone.
  * [year] The year to generate. Defaults to the current year.
  """

  def info(_argv, _composing_task) do
    %Igniter.Mix.Task.Info{
      example: @example,
      positional: [{:day, optional: true}, {:year, optional: true}]
    }
  end

  def igniter(igniter, argv) do
    {arguments, _argv} = positional_args!(argv)

    day = advent_day(Map.get(arguments, :day))
    year = advent_year(Map.get(arguments, :year))

    full_day_number = String.pad_leading(to_string(day), 2, "0")

    module_name = Igniter.Code.Module.parse("Advent.Year#{year}.Day#{full_day_number}")
    part_one_module_name = Igniter.Code.Module.parse("Mix.Tasks.Y#{year}.D#{full_day_number}.P1")
    part_two_module_name = Igniter.Code.Module.parse("Mix.Tasks.Y#{year}.D#{full_day_number}.P2")
    test_module_name = Igniter.Code.Module.parse("Advent.Year#{year}.Day#{full_day_number}Test")

    igniter
    |> Igniter.Code.Module.create_module(module_name, """
      def part1(args) do
        args
      end

      def part2(args) do
        args
      end
    """)
    |> Igniter.Code.Module.create_module(part_one_module_name, """
      use Mix.Task

      import #{module_name}

      @shortdoc "Day #{full_day_number} Part 1"
      def run(args) do
        input = Advent.Input.get!(#{day}, #{year})

        if Enum.member?(args, "-b"),
          do: Benchee.run(%{part_1: fn -> input |> part1() end}),
          else:
            input
            |> part1()
            |> IO.inspect(label: "Part 1 Results")
      end
    """)
    |> Igniter.Code.Module.create_module(part_two_module_name, """
      use Mix.Task

      import #{module_name}

      @shortdoc "Day #{full_day_number} Part 2"
      def run(args) do
        input = Advent.Input.get!(#{day}, #{year})

        if Enum.member?(args, "-b"),
          do: Benchee.run(%{part_2: fn -> input |> part2() end}),
          else:
            input
            |> part1()
            |> IO.inspect(label: "Part 2 Results")
      end
    """)
    |> Igniter.Code.Module.create_module(test_module_name, """
      use ExUnit.Case

      import #{module_name}

      @tag :skip
      test "part1" do
        input = nil
        result = part1(input)

        assert result
      end

      @tag :skip
      test "part2" do
        input = nil
        result = part2(input)

        assert result
      end
    """,
    path: Igniter.Code.Module.proper_test_location(test_module_name))
  end

  defp advent_day(nil) do
    {:ok, now} = DateTime.now("America/New_York")
    now.day
  end

  defp advent_day(day) when is_binary(day) do
    case Integer.parse(day) do
      {day, _} when day in 1..25 ->
        day

      _ ->
        raise ArgumentError, "provide a valid day number from 1–25"
    end
  end

  defp advent_year(nil) do
    {:ok, now} = DateTime.now("America/New_York")
    now.year
  end

  defp advent_year(year) when is_binary(year) do
    case Integer.parse(year) do
      {year, _} ->
        year

      _ ->
        raise ArgumentError, "provide a valid year"
    end
  end
end
