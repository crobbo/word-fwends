class Guess < ApplicationRecord
  belongs_to :game


  include ActionView::RecordIdentifier

  after_update_commit do
    # rather than doing this, I could just replace the form in puts with divs
    broadcast_remove_to [game, :guesses], target: "input_#{dom_id(self)}"
    broadcast_replace_to [game, :guesses], target: dom_id(self)

    broadcast_replace_to [game, :guesses], target: "#{game.id}_key_#{value}",
                                           partial: 'games/key',
                                           locals: { guess: self, game: game }


  end
end
