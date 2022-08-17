class RemoveColumnFromGame < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :state, :string
  end
end
