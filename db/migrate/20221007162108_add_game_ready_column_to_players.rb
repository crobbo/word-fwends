class AddGameReadyColumnToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :ready, :boolean, default: false
  end
end
