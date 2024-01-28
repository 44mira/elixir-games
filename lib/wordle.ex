defmodule Games.Wordle do
  @moduledoc """
  Wordle game

  ## Rules
    - Green:  Correct Letter, Correct Spot
    - Yellow: Correct Letter, Wrong Spot
    - Gray:   Incorrect Letter

  ## Functions
    - `play/0`: starts a game of Wordle
    - `feedback/2`: returns the feedback of an `answer` against a `turn`

  ## Examples

      iex> Games.Wordle.feedback('ABCDE', 'AABAA')
      [:green, :gray, :yellow, :gray, :gray]

  """
  @word_list ["TOAST", "TARTS", "HELLO", "BEATS", "APPLE", "BEACH", "CLOUD", "DANCE", "ELEPH", "FIFTH", "GRAPE",
    "HAPPY", "IGLOO", "JOLLY", "KNOTS", "LUNAR", "MANGO", "NOBLE", "OCEAN", "PIANO", "QUARK", "RIDER", "SHINY", "TRUMP", "UNZIP", "VIVID",
    "WRIST", "XEROX", "YACHT", "ZEBRA"]


  @doc """
  Feedback for `guess` based on `answer`.

  Both arguments must be charlists.

  ## Examples

      iex> Games.Wordle.feedback 'green', 'neerr'
      [:yellow, :yellow, :green, :yellow, :gray]

  """
  @spec feedback(charlist(), charlist()) :: list(atom())
  def feedback(answer, guess) do
    first_pass = Enum.zip([answer, guess])
    |> Enum.map(fn a ->
      case a do
        {b, b} -> :green
        _other -> a
      end
    end)

    counts = for {k, _} <- first_pass, reduce: %{} do
      acc -> Map.update(acc, k, 1, & &1+1)
    end

    {a, _} = first_pass
    |> Enum.map_reduce(counts, fn x, acc ->
      if x != :green do
        {_, v} = x
        if Map.get(acc, v, 0) > 0 do
          {:yellow, Map.update!(acc, v, & &1-1)}
        else
          {:gray, acc}
        end
      else
        {:green, acc}
      end
    end)
    a
  end

  @doc """
  Main play/2 function.
  `answer` and `rounds` parameters can be used to determine starting values, effectively rigging the game for testing.
  `answer` only takes charlists and game defaults at a maximum of 6 rounds before losing.

  ## Examples

      iex> Games.Wordle.play
      Input guess: zebra
      gray | yellow | gray | gray | gray
      Input guess: eleph

      WOOHOO YOU WIN!
      :ok

  """
  @spec play(nil | charlist(), integer()) :: :ok
  def play(answer \\ nil, rounds \\ 6)
  def play(answer, 0), do: IO.puts("You lost! The word was #{answer}.")
  def play(answer, rounds) do
    answer = answer || (Enum.random(@word_list) |> String.to_charlist)    # short-circuit to retain answer on recursion

    guess = IO.gets("Input guess: ") |> String.trim |> String.upcase
    result = feedback(answer, String.to_charlist(guess))
    cond do
      Enum.all?(result, & &1 == :green) -> IO.puts("\n" <> IO.ANSI.magenta_background <> "Congratulations! You win." <> IO.ANSI.reset)
      true ->
        result
        |> Enum.map(fn color ->
          case color do
            :green -> IO.ANSI.green() <> "green" <> IO.ANSI.reset
            :yellow -> IO.ANSI.yellow() <> "yellow" <> IO.ANSI.reset
            :gray -> IO.ANSI.light_black() <> "gray" <> IO.ANSI.reset
          end
        end)
        |> Enum.join(" | ")
        |> IO.puts
        play(answer, rounds-1)
    end
  end
end
