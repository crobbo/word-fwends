class Game < ApplicationRecord  
  has_many :guesses, foreign_key: 'game_id', dependent: :destroy
  has_many :players, foreign_key: 'game_id', dependent: :destroy

  accepts_nested_attributes_for :guesses, reject_if: proc { |attributes| attributes['value'].blank? }

  def random_word
    Spicy::Proton.noun(min: 5, max: 5)
  end

  def spell_check(guess)
    response = Faraday.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{guess}")
    return true if response.status == 200
    return false if response.status == 404
  end

  def check_word?
    return false unless spell_check(last_guess_string(last_guess))

    last_guess.each_with_index do |guess, index|
      guess.row = guess_no
      guess.result = check_letter(guess.value, index, guess.row)
      guess.save
    end
  end

  def broadcastables
    if over?
      broadcast_result
      broadcast_player_ready
      broadcast_waiting_message
      broadcast_hide_keyboard
    end
  end

  def broadcast_result
    broadcast_update_to [self, :guesses], target: "#{id}_result_section",
                                            partial: 'games/result',
                                            locals:  { game: self }
  end

  def broadcast_player_ready
    broadcast_update_to [self, :guesses], target: "#{id}_player_ready",
                                            partial: 'games/playerReady',
                                            locals:  { game: self, player: find_player(active_player == 1 ? 2 : 1).id }
  end

  def broadcast_waiting_message
    broadcast_update_to [self, :guesses], target: "#{id}_waiting_message",
                                            partial: 'games/waitingMessage',
                                            locals:  { game: self }
  end

  def broadcast_start_new_round_btn
    playerId = find_player(active_player == 1 ? 2 : 1).id
    broadcast_update_to [self, :guesses], target: "#{playerId}_start_new_round_btn",
                                          partial: 'games/startNewRoundBtn',
                                          locals:  { game: self }
  end

  def broadcast_hide_keyboard
    broadcast_update_to [self, :guesses], target: "#{id}_keyboard",
                                          partial: 'games/keyboard',
                                          locals:  { game: self }
  end

  def last_guess
    arr = guesses.sort_by &:updated_at
    arr.last(5)
  end

  def last_guess_string(guesses)
    guesses.map(&:value).join
  end

  def clear_last_guess
    last_guess.each do |guess|
      guess.value = ''
      guess.row = nil
      guess.save
    end
    self.guess_no -= 1
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
    return true if guess_no > 6 || win?
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

  # returns player object
  def find_player(num)
    players.select { |player| player[:player_no] == num }[0]
  end

  def check_player_two?(id)
    return false if id.nil?

    players.each do |player|
      return true if player.player_no == 2 && player.id == id
      return false if player.player_no == 2 && player.id != id
    end
  end

  def next_round
    self.word = random_word
    self.guess_no = 1
    guesses.delete_all
    self.active_player = active_player == 1 ? 2 : 1
    30.times do |i|
      guesses.create(value: '', row: guess_no)
    end
    players.each do |player|
      player.ready = false
      player.save
    end
  end

  def players_ready?
    return true if players[0].ready && players[1].ready

    false
  end
end
