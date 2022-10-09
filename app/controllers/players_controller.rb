class PlayersController < ApplicationController
  before_action :set_game, only: %i[update]

  def update
    # store session for player one who always sets the game up
    session[:player_id] = @player.id if @player.player_no == 1

    @player.update(player_params)
    respond_to do |format|
      if @player.save
        format.html { redirect_to @player.game }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def status
    if session[:player_id] == params[:player_id]
      @player = Player.find(params[:player_id])
      @player.update(ready: params[:status])
      @player.save
    end
  end

  private

  def set_game
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:id, :name, :game_id, :status)
  end
end
