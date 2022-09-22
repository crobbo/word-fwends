class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :name
      t.integer :player_no
      t.uuid :game_id

      t.timestamps
    end
  end
end
