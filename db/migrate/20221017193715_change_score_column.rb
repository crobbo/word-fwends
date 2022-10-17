class ChangeScoreColumn < ActiveRecord::Migration[7.0]
  def change
    change_column_default :players, :score, from: nil, to: 0
  end
end
