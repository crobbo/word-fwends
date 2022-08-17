class AddColumnsToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :guess_no, :integer
  end
end
