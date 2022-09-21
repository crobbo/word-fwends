class Game < ApplicationRecord
  has_many :guesses, foreign_key: 'game_id', dependent: :destroy

  accepts_nested_attributes_for :guesses, reject_if: proc { |attributes| attributes['value'].blank? }

  def random_word
    Spicy::Proton.noun(min: 5, max: 5)
  end

  def check_word?
    last_guess.each_with_index do |guess, index|
      guess.row = guess_no
      guess.result = check_letter(guess.value, index, guess.row)
      guess.save
    end
  end

  def broadcastables
    broadcast_word
    broadcast_win
  end

  def broadcast_word
    if over? || win?
      broadcast_update_to [self, :guesses], target: "#{id}_word_section",
                                             partial: 'games/word',
                                             locals:  { game: self }
    end
  end

  def broadcast_win
    if over? || win?
      broadcast_update_to [self, :guesses], target: "#{id}_win_section",
                                             partial: 'games/win',
                                             locals:  { game: self }
    end
  end

  def last_guess
    arr = guesses.sort_by &:updated_at
    arr.last(5)
  end

  def check_letter(guess, index, row)
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
    return 0 if guesses.count.zero?

    guesses.all.where("value = '#{guess.downcase}' AND row = #{row} ").count
  end

  def check_exact_match?(guess, index)
    word[index] == guess
  end

  def check_partial_match(guess, row)
    occurance = letter_count(guess)
    guess_total = prev_guess_count(guess, row)

    case occurance
    when 1
      if guess_total.zero?
        'occurs'
      else
        'miss'
      end
    when 2
      if guess_total.zero?
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

  def win?
    guesses.all.where("row = #{guess_no} AND result = 'match' ").count == 5
  end

  def over?
    return true if guess_no > 6 # && last_guess.all? { |guess| guess.result == 'miss' || guess.result == 'occurs' }

    false
  end

  def matches?(letter)
    guesses.all.where("value = '#{letter}' AND result = 'match'").count.positive?
  end

  def occurances?(letter)
    guesses.all.where("value = '#{letter}' AND result = 'occurs'").count.positive?
  end

  def misses?(letter)
    guesses.all.where("value = '#{letter}' AND result = 'miss'").count.positive?
  end
end
