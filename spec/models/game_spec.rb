require 'rails_helper'

RSpec.describe Game, type: :model do

  context 'last_guess method' do
    it 'returns array of last five guesses' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      a = Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      b = Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      c = Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      d = Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      e = Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      f = Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      g = Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      h = Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      i = Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      j = Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      k = Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      l = Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      m = Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      n = Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      o = Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'miss')
      expect(game.last_guess).to eq([k, l, m, n, o])
    end

    it 'returns array of last five guesses' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      a = Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      b = Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      c = Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      d = Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      e = Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      k = Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      l = Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      m = Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      n = Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      o = Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'miss')
      expect(game.last_guess).to eq([k, l, m, n, o])
    end
  end

  context 'check_word method?' do
    
  end

  context 'check_exact_match? method' do
    it 'returns true if letter is in word' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_exact_match?('a', 0)).to eq(true)
    end
    it 'returns true if letter is in word' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_exact_match?('l', 3)).to eq(true)
    end
  end

  context 'prev_guess_count method' do
    it 'returns 0 if letter not already guessed' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.prev_guess_count('a', 1)).to eq(0)
    end

    it 'returns 3 if letter not already guessed' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 3)
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 3)
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 3)
      expect(game.prev_guess_count('a', 3)).to eq(3)
    end
  end

  context 'letter_count method' do
    it 'returns 1 if letter occurs once' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.letter_count('a')).to eq(1)
    end

    it 'returns 2 if letter occurs twice' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.letter_count('p')).to eq(2)
    end
  end

  context 'check_partial_match method' do
    it 'returns "occurs" if letter occurs once and has NOT been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 1)
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 1)
      Guess.create(value: 'y', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 1)
      expect(game.check_partial_match('a', 1)).to eq('occurs')
    end
    it 'returns "miss" if letter occurs once and has been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 3)
      expect(game.check_partial_match('a', 3)).to eq('miss')
    end

    it 'returns "occurs" if letter occurs twice and has NOT been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'm', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_partial_match('p', 3)).to eq('occurs')
    end

    it 'returns "occurs" if letter occurs twice and has been guessed once previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 1)
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 2)
      expect(game.check_partial_match('p', 2)).to eq('occurs')
    end

    it 'returns "miss" if letter occurs twice and has been guessed twice previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 2)
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', row: 2)
      expect(game.check_partial_match('p', 2)).to eq('miss')
    end
  end

  context 'check_letter method' do
    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('a', 0, 1)).to eq('match')
    end

    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('p', 2, 3)).to eq('match')
    end

    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('p', 1, 2)).to eq('match')
    end

    it "returns 'miss' when letter is not in word" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('z', 3, 5)).to eq('miss')
    end

    it "returns 'miss' when letter is not in word" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('o', 4, 5)).to eq('miss')
    end

    it "returns 'occurs' when letter occurs in word but is not exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('a', 3, 3)).to eq('occurs')
    end

    it "returns 'occurs' when letter occurs in word but is not exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      expect(game.check_letter('e', 1, 3)).to eq('occurs')
    end

    it "returns 'miss' when letter occurs once in word but has already been guessed" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1)
      expect(game.check_letter('e', 2, 1)).to eq('miss')
    end

    it "returns 'occurs' when letter occurs twice in word but has been guessed once and is NOT exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3)
      expect(game.check_letter('p', 4, 3)).to eq('occurs')
    end

    it "returns 'miss' when letter occurs twice in word but has been guessed twice" do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3)
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3)
      expect(game.check_letter('p', 4, 3)).to eq('miss')
    end
  end

  context 'win? method' do
    it 'returns false if 4 of last 5 guesses all match' do
      game = Game.create(word: 'apple', guess_no: 0, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'miss')
      expect(game.win?).to eq(false)
    end

    it 'returns true if last 5 guesses all match' do
      game = Game.create(word: 'apple', guess_no: 3, id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'match')
      expect(game.win?).to eq(true)
    end
  end

  context 'matches? method' do
    it 'returns true if letter is a match' do
      game = Game.create(word: 'apple', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'match')
      expect(game.matches?('e')).to eq(true)
    end

    it 'returns true if letter is a match' do
      game = Game.create(word: 'apple', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'match')
      expect(game.matches?('a')).to eq(true)
    end

    it 'returns false if letter is not a match' do
      game = Game.create(word: 'apple', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'match')
      expect(game.matches?('z')).to eq(false)
    end

    it 'returns false if letter is not a match' do
      game = Game.create(word: 'apple', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 3, result: 'match')
      expect(game.matches?('y')).to eq(false)
    end

    it 'returns true if letter occurs' do
      game = Game.create(word: 'apple', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'miss')
      expect(game.occurances?('a')).to eq(true)
    end

    it 'returns  true if letter is occurs' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.occurances?('s')).to eq(true)
    end

    it 'returns false if letter does not occurs' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.occurances?('f')).to eq(false)
    end

    it 'returns false if letter does not occurs' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.occurances?('h')).to eq(false)
    end

    it 'returns true if letter misses' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.misses?('h')).to eq(true)
    end

    it 'returns true if letter misses' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.misses?('f')).to eq(true)
    end


    it 'returns false if letter does not miss' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.misses?('s')).to eq(false)
    end


    it 'returns false if letter does not miss' do
      game = Game.create(word: 'mists', id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a')
      Guess.create(value: 's', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 1, row: 1, result: 'occurs')
      Guess.create(value: 'h', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 2, row: 1, result: 'miss')
      Guess.create(value: 'i', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', col: 5, row: 1, result: 'occurs')
      expect(game.misses?('i')).to eq(false)
    end
  end
end