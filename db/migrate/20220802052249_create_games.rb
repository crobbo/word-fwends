class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :state
      t.string :word

      t.timestamps
    end
  end
end
