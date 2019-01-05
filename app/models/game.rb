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
    winning_boards = {
      "X" => [],
      "O" => []
    }

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

  def winner?
    winning_boards.each do |player, boards|
      WINNING_COMBINATIONS.each do |combination|
        first_cell = boards[0]
        second_cell = boards[1]
        third_cell = boards[2]
        consideration = [first_cell, second_cell, third_cell]

        if WINNING_COMBINATIONS.include?(consideration)
          self.winner = player
          self.save
        end
      end
    end

    self.winner
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
