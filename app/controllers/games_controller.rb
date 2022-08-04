class GamesController < ApplicationController
  before_action :set_game, only: %i[:show,:update]

  

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = set_game
  end

  def create
    redirect_to Game.create(game_params)
  end

  private 

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:state)
  end
end
