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

    resp = game.move(subgame, cell)

    render json: resp
  end
end
