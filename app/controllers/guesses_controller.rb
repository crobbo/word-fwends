class GuessesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
    @game = Game.find(params[:game_id])    

    if @game.state.length < 30
      @guess = Guess.create(game_id: params[:game_id], value: params[:value])
      @game.guess!(@guess.value)
      @game.save
      redirect_to @game
    end
  end

  def edit
  end
end
