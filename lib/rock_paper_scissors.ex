defmodule Games.RockPaperScissors do
  @moduledoc """
  Rock paper scissors game played on the CLI after a call to `Games.RockPaperScissors.play/0`
  """
  alias Games.Score

  @doc """
  Generates a choice between rock/paper/scissors and gets game result based on `player` choice.

  ## Examples

      iex> Games.RockPaperScissors.play
      Games.RockPaperScissors.play
      Choose rock, paper, or scissors: paper
      Bot throws rock!
      You win! Paper beats rock.
      :ok

  """
  @spec play :: :ok
  def play() do
    bot    = Enum.random([:rock, :paper, :scissors])
    player = IO.gets("Choose rock, paper, or scissors: ") |> String.trim |> String.to_atom

    IO.puts("Bot throws #{Atom.to_string(bot)}!")
    case {bot, player} do
      {n, n} -> "It's a tie!"
      {:rock, :paper} ->
        Score.add_score(:rps_win)
        "You win! Paper beats rock."
      {:paper, :scissors} ->
        Score.add_score(:rps_win)
        "You win! Scissors beats paper."
      {:scissors, :rock} ->
        Score.add_score(:rps_win)
        "You win! Rock beats scissors."
      {a, b} -> "You lose! #{Atom.to_string(a) |> String.capitalize} beats #{Atom.to_string(b)}."
    end
    |> IO.puts
  end

end
