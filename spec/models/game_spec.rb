require "rails_helper"

describe Game do
  let(:game) { Game.new }

  it 'initializes with 9 inner boards (arrays)' do
    game = Game.new

    expect(game.board.count).to eq 9
    expect(game.board.map(&:class).count(Array)).to eq 9
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

  describe "set_winner" do
    it "sets the winner of the game if there is one" do
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

      game.set_winner

      expect(game.winner).to eq "X"
    end
  end

  describe "cell_vacant?" do
    it 'returns true if the cell is unoccupied' do
      expect(game.cell_vacant?(0, 0)).to eq true
    end

    it 'returns false if the cell is occupied' do
      game.move(0, 0)
      expect(game.cell_vacant?(0, 0)).to eq false
    end
  end

  describe "#move" do
    it 'places the piece on the board' do
      game.move(0, 0)
      expect(game.board[0][0]).to eq "X"

      game.move(0, 1)
      expect(game.board[0][1]).to eq "O"
    end

    context "invalid subgame" do
      it "returns an invalid move error " do
        game.valid_subgames = [0]

        expect(game.move(2, 0)).to eq ({ error: "Invalid move" })
      end
    end
  end

  context "cell is occupied" do
    it "returns a cell-occupied error " do
      game.valid_subgames = [0]

      game.move(0, 0)

      expect(game.move(0, 0)).to eq ({ error: "Cell occupied" })
    end
  end
end
