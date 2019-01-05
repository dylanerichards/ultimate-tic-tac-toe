class GamesController < ApplicationController
  def show
    begin
      game = Game.find(params[:id])

      render json: game
    rescue
      render json: { error: "Invalid ID" }
    end

  end

  def new
    game = Game.create

    render json: game
  end

  def move
    game = Game.find(params[:id])
    subgame = params[:subgame].to_i
    cell = params[:cell].to_i
    turn = game.turn

    if game.board[subgame][cell].blank?

      game.board[subgame][cell] = turn
      game.turn = game.turn == "X" ? "O" : "X"
      game.valid_subgames = game.valid_subgames = [cell]

      game.save
      resp = game
    else
      resp = { error: 'Cell occupied' }
    end

    render json: resp
  end
end
