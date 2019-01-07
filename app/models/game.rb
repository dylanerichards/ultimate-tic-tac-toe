class Game < ApplicationRecord
  serialize :valid_subgames
  serialize :board
  after_initialize :create_boards, if: :new_record?

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def winning_boards
    winning_boards = { "X" => [], "O" => [] }

    self.board.each_with_index do |board, index|
      WINNING_COMBINATIONS.each do |combination|
        first_cell = board[combination[0]]
        second_cell = board[combination[1]]
        third_cell = board[combination[2]]
        consideration = [first_cell, second_cell, third_cell]

        winning_boards[first_cell] << index if consideration.uniq.length == 1 && first_cell.blank? == false
      end
    end

    winning_boards
  end

  def set_winner
    winning_boards.each do |player, boards|
      WINNING_COMBINATIONS.each do |combination|
        consideration = [boards[0], boards[1], boards[2]]

        if WINNING_COMBINATIONS.include?(consideration)
          self.winner = player
          self.save
        end
      end
    end

    self.winner
  end

  def valid_subgame?(subgame)
    valid_subgames.include?(subgame)
  end

  def cell_vacant?(cell, subgame)
    board[subgame][cell].blank?
  end

  def move(subgame, cell)
    if valid_subgame?(subgame) && cell_vacant?(cell, subgame)
      tap do |game|
        game.board[subgame][cell] = turn
        game.turn = turn == "X" ? "O" : "X"
        game.valid_subgames = [cell]
        game.save
        game.set_winner
      end
    elsif !valid_subgame?(subgame)
      { error: "Invalid move" }
    else
      { error: "Cell occupied" }
    end
  end

  def create_boards
    self.board = [
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '', ''],
    ]

    self.save
  end
end
