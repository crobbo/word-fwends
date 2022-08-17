class AddColumnsToGuess < ActiveRecord::Migration[7.0]
  def change
    add_column :guesses, :row, :integer
    add_column :guesses, :col, :integer
    add_column :guesses, :result, :string
  end
end
