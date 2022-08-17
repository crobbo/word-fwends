class GuessesController < ApplicationController
  before_action :set_game, only: %i[create]

  def index
  end

  def new
  end

  def show
  end

  def create
    # binding.pry
    5.times do |i|
      guess = Guess.create(game_id: @game.id)
      guess.value = params["value_#{i}".to_sym].downcase
      guess.row = @game.guess_no
      guess.col = i
      guess.result = @game.check_guess?(guess.value, guess.col, guess.row)
      guess.save
    end
    @game.guess_no += 1
    @game.save
    redirect_to @game
  end

  def edit
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def guess_params
    # params.require(:guess).permit(:value, :game_id)
  end

end
