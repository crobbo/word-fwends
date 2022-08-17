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
    @guess = Guess.new
  end

  def create
    @game = Game.create
    @game.word = @game.random_word
    @game.guess_no = 1
    @game.save
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word)
  end
end
