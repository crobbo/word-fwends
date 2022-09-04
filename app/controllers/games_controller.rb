class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
  end

  def create
    @game = Game.create
    @game.guess_no = 1
    @game.word = @game.random_word

    30.times do |i|
      @game.guesses.create(value: '', row: @game.guess_no)
    end

    @game.save
    redirect_to @game
  end

  def update
    @game.guess_no += 1
    @game.update(game_params)
    @game.save
    @game.check_word?
    @game.broadcastables
    redirect_to @game
  end

  def edit
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word, guesses_attributes: %i[value id])
  end
end
