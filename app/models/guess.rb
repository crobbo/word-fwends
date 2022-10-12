class Guess < ApplicationRecord
  belongs_to :game

  include ActionView::RecordIdentifier

  after_update_commit do
    broadcast_update_to [game, :guesses], target: "input_#{dom_id(self)}"

    broadcast_replace_to [game, :guesses], target: "#{game.id}_key_#{value}",
                                           partial: 'games/key',
                                           locals: { guess: self, game: game, letter: value }
  end
end
