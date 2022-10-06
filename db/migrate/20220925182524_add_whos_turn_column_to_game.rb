class AddWhosTurnColumnToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :active_player, :integer, default: 1
  end
end
