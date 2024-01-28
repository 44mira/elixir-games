defmodule Games.Menu do
  @moduledoc """
  Games menu for executable

  ## Processing roadmap:

  `prompt/0`
  |> `menu/1`
  |> `loop/1`
  |> `prompt/0` | :ok

  """

  @type game :: :guess | :rps | :wordle

  def main(_args), do: prompt()

  @spec prompt :: :ok
  defp prompt do
    IO.puts(~s"""

    What game would you like to play?
    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    Enter "stop" to exit
    """)

    IO.gets(">> ")
    |> String.trim
    |> menu
    |> loop
  end

  @spec menu(game) :: :ok | :err
  defp menu("1"), do: Games.GuessingGame.play
  defp menu("2"), do: Games.RockPaperScissors.play
  defp menu("3"), do: Games.Wordle.play
  defp menu("stop"), do: :stop
  defp menu(_), do: :err

  @spec loop(:ok | :stop | :err) :: :ok
  defp loop(:ok), do: prompt()
  defp loop(:stop), do: :ok
  defp loop(:err) do
    IO.puts("Invalid input. Try again.\n\n")
    prompt()
  end

end
