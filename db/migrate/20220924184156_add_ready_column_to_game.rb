class AddReadyColumnToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :ready, :boolean, default: false
  end
end
