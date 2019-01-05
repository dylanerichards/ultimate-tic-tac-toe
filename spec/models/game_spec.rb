require "rails_helper"

describe Game do
  it 'initializes with 9 inner boards (arrays)' do
    game = Game.new

    expect(game.board.count).to eq 9
    expect(game.board.map(&:class))
  end

  describe "#winning_boards" do
    it "identifies inner-board winners" do
      game = Game.new
      game.board = [
        ['X', 'X', 'X', '', '', '', '', '', ''],
        ['O', 'O', 'O', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
      ]

      game.save

      expect(game.winning_boards).to eq({ "X" => [0], "O" => [1] })
    end
  end

  describe "#winner?" do
    it "checks for a winner of the game" do
      game = Game.new
      game.board = [
        ['X', 'X', 'X', '', '', '', '', '', ''],
        ['X', 'X', 'X', '', '', '', '', '', ''],
        ['X', 'X', 'X', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '', ''],
      ]

      game.winner?

      expect(game.winner).to eq "X"
    end
  end
end
