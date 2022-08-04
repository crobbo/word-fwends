class Game < ApplicationRecord
  has_many :guesses, foreign_key: "game_id", dependent: :destroy

  def guess!(letter)
    self.state = self.state + letter
  end

  def undo_guess!
    self.state = self.state.chop
  end

  def current_guess
    self.state.slice(-1)
  end

  # checks letter exising in word
  def includes_letter?(letter)
    self.word.include?(letter.downcase)
  end

  def letter_match?(letter)
    letter.downcase == self.word.split(//)[return_index]
  end

  # returns index of last guess
  def return_index
    row = return_row(self.state.length)
    if row == 1
      self.state.length - 1
    elsif row == 2
      self.state.length - 6
    elsif row == 3
      self.state.length - 11
    elsif row == 4
      self.state.length - 16
    elsif row == 5
      self.state.length - 21
    elsif row == 6
      self.state.length - 26
    end
  end

  # returns row no. of last guess
  def return_row(num)
    case num
    when 0..5
      1
    when 6..10
      2
    when 11..15
      3
    when 16..20
      4
    when 21..25
      5
    when 26..30
      6
    end
  end
end
