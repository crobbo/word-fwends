class CreateGuesses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesses do |t|
      t.integer :game_id
      t.string :value

      t.timestamps
    end
  end
end
