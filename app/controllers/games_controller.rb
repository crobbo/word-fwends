class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    # Only store session for Player 2
    session[:player_id] = params[:player_two] if !params[:player_two].nil? && @game.check_player_two?(params[:player_two])
    if params[:ready]
      @game.ready = true
      @game.save
    end
  end

  def create
    @game = Game.create
    @game.guess_no = 1
    @game.word = @game.random_word
    Player.create(name: '', game_id: @game.id, player_no: 1)
    Player.create(name: '', game_id: @game.id, player_no: 2)

    30.times do |i|
      @game.guesses.create(value: '', row: @game.guess_no)
    end

    @game.save
    redirect_to @game
  end

  def update
    if @game.over?
      @game.next_round
    else
      @game.guess_no += 1
      @game.update(game_params)
    end
    respond_to do |format|
      if @game.save
        @game.check_word?
        @game.broadcastables
        format.html { redirect_to @game }
        # format.turbo_stream { render turbo_stream: turbo_stream.replace('#{dom_id(@game)}', partial: 'games/form') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
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
