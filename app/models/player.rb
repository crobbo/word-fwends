class Player < ApplicationRecord
  belongs_to :game

  def capitalize_name
    name.capitalize
  end
end
