defmodule Games.Menu do
  @moduledoc """
  Games menu for executable

  ## Processing roadmap:

  `prompt/0`
  |> `menu/1`
  |> `prompt/0` | :ok

  """
  @type choice :: :ok | :err | :stop | :score
  alias Games.Score

  def main(_args) do
    child = [{Score, []}]
    Supervisor.start_link(child, strategy: :one_for_one)
    prompt()
  end

  @spec prompt :: :ok
  defp prompt do
    IO.puts("\x1b[H\x1b[2J")
    IO.puts(~s"""
    \nWhat game would you like to play?
    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    Enter "stop" to exit, "score" to view current score
    """)

    choice = IO.gets(">> ")
    |> String.trim
    |> menu

    case choice do
      :stop -> :ok
      :ok   ->
        Process.sleep(3000)
        prompt()
      :err  ->
        IO.puts("Invalid input. Try again.\n\n")
        Process.sleep(2500)
        prompt()
      :score ->
        IO.puts(~s"""
        \n===============
        Score: #{Score.get_score()}
        ===============
        """)
        Process.sleep(2500)
        prompt()
    end
  end

  @spec menu(String.t) :: choice
  defp menu("1"), do: Games.GuessingGame.play
  defp menu("2"), do: Games.RockPaperScissors.play
  defp menu("3"), do: Games.Wordle.play
  defp menu("stop"), do: :stop
  defp menu("score"), do: :score
  defp menu(_), do: :err

end
