defmodule Games.GuessingGame do
  @moduledoc """
  Guessing game

  """

  @doc """
  Generates a random number from 1 to 10, player wins on correct guess.

  Starts a recursive call to play_rec/2 to abstract away `target`.
  `target` stores the initial rolled value.
  `attempts` tracks 5 attempts before player loses.

  ## Examples
    iex> Games.GuessingGame.play()
    Guess a number between 1 and 10: 3
    You win!

  """
  def play(), do: play_rec(5)

  defp play_rec(attempts, target \\ nil)
  defp play_rec(0, target), do: IO.puts("You lose! The answer was #{target}")
  defp play_rec(attempts, target) do
    target = target || Enum.random(1..10)  # short-circuit keep track of initial value
    guess  = IO.gets("Guess a number between 1 and 10: ")
    |> String.trim
    |> String.to_integer

    cond do
      guess == target -> IO.puts "You win!"
      guess < target  ->
        IO.puts "Too Low!"
        play_rec(attempts-1, target)
      guess > target  ->
        IO.puts "Too High!"
        play_rec(attempts-1, target)
    end
  end
end
