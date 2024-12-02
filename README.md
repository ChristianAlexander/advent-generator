# Advent

An [Advent of Code](https://www.adventofcode.com) boilerplate for Elixir.

Uses [Ash Project’s Igniter tool](https://github.com/ash-project/igniter) to generate each day’s template files.

Based on [Mitchell Hanberg’s advent-of-code-elixir-starter](https://github.com/mhanberg/advent-of-code-elixir-starter).

Watch the related YouTube video:

[![Watch the video](https://img.youtube.com/vi/gpaV4bgEG-g/maxresdefault.jpg)](https://youtu.be/gpaV4bgEG-g)

## Usage

Each day in December, run `mix advent.generate.day` to generate files related to the current day’s challenge.

This will generate the following files:
- `Advent.Year1234.Day01`: Write your solution here
- `Advent.Year1234.Day01Test`: Write tests here
- `Mix.Tasks.Year1234.D01.P1`: A mix task to run part 1 of the day’s challenge with your input
- `Mix.Tasks.Year1234.D01.P2`: A mix task to run part 2 of the day’s challenge with your input

### Specify a day

To generate a specific day’s files, add the `day` and optionally the `year` positional arguments to the generation command.
For example, to generate December 1, 2022’s file:
```bash
mix advent.generate.day 1 2022
```

### Optional Automatic Input Retriever

This starter comes with a module that will automatically get your inputs so you
don't have to mess with copy/pasting. Don't worry, it automatically caches your
inputs to your machine so you don't have to worry about slamming the Advent of
Code server. You will need to configure it with your cookie and make sure to
enable it.

Make sure to set the `ADVENT_OF_CODE_SESSION_COOKIE` environment variable and set `allow_network?` to `true` in [config/config.exs](config/config.exs).

After which, you can retrieve your inputs using the module:

```elixir
day = 1
year = 2020
AdventOfCode.Input.get!(day, year)
# or just have it auto-detect the current year
AdventOfCode.Input.get!(7)
# and if your input somehow gets mangled and you need a fresh one:
AdventOfCode.Input.delete!(7, 2019)
# and the next time you `get!` it will download a fresh one -- use this sparingly!
```


### Testing and Running your code

You can adjust your test to reflect the sample provided at the challenge description. And run your tests:
```bash
mix test --only y2024.d01.p1
mix test --only y2024.d01
mix text --only y2024
```

This syntax is pretty straight forward, the first one will run the test for a particular part, the second will run all the tests for that day, and the third one for the year.

As you progress with the challenge you'll find edge cases, and you can create your own tests for that and even reuse some of those tags.

When you're done with testing you can run your code with the command:
```bash
mix y2024.d01.p1
```

The identification of the task to run your code and the name of the test follows the same structure, so it's easy to move between those.


