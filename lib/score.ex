defmodule Games.Score do
  use GenServer

  def start_link(_opts), do: GenServer.start_link(__MODULE__, [], name: Score)
  def add_score(game_win), do: GenServer.cast(Score, game_win)
  def get_score(), do: GenServer.call(Score, :current_score)

  @impl true
  def init(_state), do: {:ok, 0}

  @impl true
  def handle_cast(:guess_win, score), do: {:noreply, score + 5}
  def handle_cast(:rps_win, score), do: {:noreply, score + 10}
  def handle_cast(:wordle_win, score), do: {:noreply, score + 20}

  @impl true
  def handle_call(:current_score, _from, score), do: {:reply, score, score}
end
