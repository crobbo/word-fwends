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

    last_guess.each_with_index do |letter, index|
      letter.row = guess_no
      letter.result = check_letter(letter.value, index, letter.row)
      letter.save
    end
  end

  def broadcastables
    broadcast_guesses
    if over?
      broadcast_result
      broadcast_player_ready
      broadcast_waiting_message
      broadcast_hide_keyboard
      broadcast_scoreboard
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
    player_id = find_player(active_player == 1 ? 2 : 1).id
    broadcast_update_to [self, :guesses], target: "#{player_id}_start_new_round_btn",
                                          partial: 'games/startNewRoundBtn',
                                          locals:  { game: self }
  end

  def broadcast_hide_keyboard
    broadcast_update_to [self, :guesses], target: "#{id}_keyboard",
                                          partial: 'games/keyboard',
                                          locals:  { game: self }
  end

  def broadcast_scoreboard
    broadcast_update_to [self, :guesses], target: "#{id}_scoreboard",
                                          partial: 'games/scoreboard',
                                          locals:  { game: self }

    broadcast_update_to [self, :guesses], target: "#{id}_scoreboardBtn",
                                          partial: 'games/scoreboardBtn',
                                          locals:  { game: self }
  end

  def broadcast_guesses
    last_guess.each do |guess|
      broadcast_update_to [self, :guesses], target: "input_guess_#{guess.id}", partial: 'guesses/guess', locals: { guess: guess }

      broadcast_replace_to [self, :guesses], target: "#{self.id}_key_#{guess.value}",
                                             partial: 'games/key',
                                             locals: { guess: guess, game: self, letter: guess.value }
    end
  end

  def last_guess
    arr = guesses.sort_by &:updated_at
    arr.last(5)
  end

  def last_guess_string(guesses)
    guesses.map(&:value).join
  end

  def clear_last_guess
    last_guess.each do |letter|
      letter.value = ''
      letter.row = nil
      letter.save
    end
    self.guess_no -= 1
  end

  def check_letter(letter, index, row)
    if check_exact_match?(letter, index)
      'match'
    elsif word.include?(letter)
      check_partial_match(letter, row)
    else
      'miss'
    end
  end

  def letter_count(letter)
    count = 0
    word.each_char { |char| if char == letter then count += 1 end }
    count
  end

  def prev_guess_count(letter, row)
    return 0 if guesses.count.zero?

    guesses.all.where("value = '#{letter.downcase}' AND row = #{row} ").count
  end

  def check_exact_match?(letter, index)
    word[index] == letter
  end

  def check_partial_match(letter, row)
    occurance = letter_count(letter)
    guess_total = prev_guess_count(letter, row)

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
      return false if player.player_no == 1 && player.id != id
      return false if player.player_no == 1 && player.id == id
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

  def calc_score(player)
    case self.guess_no
    when 2
      player.score += 150
    when 3
      player.score += 120
    when 4
      player.score += 90
    when 5
      player.score += 60
    when 6
      player.score += 30
    when 7
      player.score += 10 if win?
    end
    player.save
  end
end
