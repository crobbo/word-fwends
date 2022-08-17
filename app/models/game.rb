class Game < ApplicationRecord
  has_many :guesses, foreign_key: 'game_id', dependent: :destroy

  def random_word
    Spicy::Proton.noun(min: 5, max: 5)
  end

  def check_guess?(guess, index, row)
    if check_exact_match?(guess, index)
      'match'
    elsif word.include?(guess)
      check_partial_match(guess, row)
    else
      'miss'
    end
  end

  def letter_count(guess)
    count = 0
    word.each_char { |letter| if letter == guess then count += 1 end }
    count
  end

  def prev_guess_count(guess, row)
    self.guesses.all.where("value == '#{guess}' AND row == #{row} ").count
  end

  def check_exact_match?(guess, index)
    word[index] == guess
  end

  def check_partial_match(guess, row)
    occurance = letter_count(guess)
    guess_total = prev_guess_count(guess, row)

    case occurance
    when 1
      if guess_total == 0
        'occurs'
      else
        'miss'
      end
    when 2
      if guess_total == 0
        'occurs'
      elsif guess_total == 1
        'occurs'
      else
        'miss'
      end
    when 3
      if guess_total.zero?
        'occurs'
      elsif guess_total == 1
        'occurs'
      elsif guess_total == 2
        'occurs'
      else
        'miss'
      end
    end
  end

  def over?
    row = guesses.count / 5
    guesses.all.where("row == #{row} AND result == 'match' ").count == 5
  end

  def matches?(letter)
    guesses.all.where("value == '#{letter}' AND result == 'match'").count.positive?
  end

  def occurances?(letter)
    guesses.all.where("value == '#{letter}' AND result == 'occurs'").count.positive?
  end
  
  def misses?(letter)
    guesses.all.where("value == '#{letter}' AND result == 'miss'").count.positive?
  end  
end
