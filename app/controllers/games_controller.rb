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
    @game.guess_no += 1
    @game.update(game_params) # letters need to be lower case
    respond_to do |format|
      if @game.save
        if @game.check_word?
          message = ''
        else
          message = 'Word does not exists'
          @game.clear_last_guess
          @game.save
        end
        @game.broadcastables
        format.html { redirect_to @game, notice: message }
        # format.turbo_stream { render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
    if @game.over? && @game.players_ready?
      @game.broadcast_start_new_round_btn
      @game.next_round
      respond_to do |format|
        if @game.save
          format.html { redirect_to @game }
        else
          format.html { render :show, status: :unprocessable_entity, notice: 'Waiting for opponent to be ready' }
        end
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word, guesses_attributes: %i[value id])
  end
end
