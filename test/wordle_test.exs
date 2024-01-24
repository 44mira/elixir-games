defmodule Games.WordleTest do
  use ExUnit.Case
  alias Games.Wordle

  describe "feedback" do
    test "all green", do: assert Enum.all?(Wordle.feedback('GREEN', 'GREEN'), & &1 === :green)
    test "all yellow", do: assert Enum.all?(Wordle.feedback('YELLOW', 'LYEOWL'), & &1 === :yellow)
    test "all gray", do: assert Enum.all?(Wordle.feedback('GRAY','NONE'), & &1 === :gray)
    test "correct assignment",
      do: assert [:green, :green, :yellow, :yellow, :gray] == Wordle.feedback('GREAT', 'GRAES')
  end

  describe "play" do
    test "end at 0", do: assert :ok == Wordle.play('ZERO', 0)
  end
end
