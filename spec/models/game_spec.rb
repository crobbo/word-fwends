require 'rails_helper'

RSpec.describe Game, type: :model do

  context 'check_exact_match? method' do
    it 'returns true if letter is in word' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_exact_match?('a', 0)).to eq(true)
    end
    it 'returns true if letter is in word' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_exact_match?('l', 3)).to eq(true)
    end
  end

  context 'letter_prev_guess method' do
    it 'returns 0 if letter not already guessed' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.prev_guess_count('a', 1)).to eq(0)
    end

    it 'returns 3 if letter not already guessed' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'a', game_id: 1, row: 3)
      Guess.create(value: 'a', game_id: 1, row: 3)
      Guess.create(value: 'a', game_id: 1, row: 3)
      expect(game.prev_guess_count('a', 3)).to eq(3)
    end
  end

  context 'letter_count method' do
    it 'returns 1 if letter occurs once' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.letter_count('a')).to eq(1)
    end

    it 'returns 2 if letter occurs twice' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.letter_count('p')).to eq(2)
    end
  end

  context 'checks number of previous guesses' do
    it 'returns 0 if no previous guesses' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.guesses.all.count).to eq(0)
    end

    it 'returns 1 if one previous guesses' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'f', game_id: 1)
      expect(game.guesses.all.count).to eq(1)
    end

    it 'returns 2 if two previous guesses' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'j', game_id: 1)
      Guess.create(value: 'c', game_id: 1)
      expect(game.guesses.all.count).to eq(2)
    end
  end

  context 'check_partial_match method' do
    it 'returns "occurs" if letter occurs once and has NOT been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 't', game_id: 1, row: 1)
      Guess.create(value: 'r', game_id: 1, row: 1)
      Guess.create(value: 'y', game_id: 1, row: 1)
      expect(game.check_partial_match('a', 1)).to eq('occurs')
    end
    it 'returns "miss" if letter occurs once and has been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'a', game_id: 1, row: 3)
      expect(game.check_partial_match('a', 3)).to eq('miss')
    end

    it 'returns "occurs" if letter occurs twice and has NOT been guessed previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 's', game_id: 1)
      Guess.create(value: 'm', game_id: 1)
      Guess.create(value: 'e', game_id: 1)
      expect(game.check_partial_match('p', 3)).to eq('occurs')
    end

    it 'returns "occurs" if letter occurs twice and has been guessed once previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'p', game_id: 1, row: 1)
      Guess.create(value: 'p', game_id: 1, row: 2)
      expect(game.check_partial_match('p', 2)).to eq('occurs')
    end

    it 'returns "miss" if letter occurs twice and has been guessed twice previously' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'p', game_id: 1, row: 2)
      Guess.create(value: 'p', game_id: 1, row: 2)
      expect(game.check_partial_match('p', 2)).to eq('miss')
    end
  end

  context 'check_guesses? method' do
    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('a', 0, 1)).to eq('match')
    end

    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('p', 2, 3)).to eq('match')
    end

    it "returns 'match' when letter is exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('p', 1, 2)).to eq('match')
    end

    it "returns 'miss' when letter is not in word" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('z', 3, 5)).to eq('miss')
    end

    it "returns 'miss' when letter is not in word" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('o', 4, 5)).to eq('miss')
    end

    it "returns 'occurs' when letter occurs in word but is not exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('a', 3, 3)).to eq('occurs')
    end

    it "returns 'occurs' when letter occurs in word but is not exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      expect(game.check_guess?('e', 1, 3)).to eq('occurs')
    end

    it "returns 'miss' when letter occurs once in word but has already been guessed" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'e', game_id: 1, col: 1, row: 1)
      expect(game.check_guess?('e', 2, 1)).to eq('miss')
    end

    it "returns 'occurs' when letter occurs twice in word but has been guessed once and is NOT exact match" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'p', game_id: 1, col: 1, row: 3)
      expect(game.check_guess?('p', 4, 3)).to eq('occurs')
    end

    it "returns 'miss' when letter occurs twice in word but has been guessed twice" do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 'p', game_id: 1, col: 1, row: 3)
      Guess.create(value: 'p', game_id: 1, col: 4, row: 3)
      expect(game.check_guess?('p', 4, 3)).to eq('miss')
    end
  end

  context 'over? method' do
    it 'returns false if 4 of last 5 guesses all match' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 's', game_id: 1, col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 1, col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 1, col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 1, col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 1, col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 1, col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 1, col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 1, col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 1, col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 1, col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 1, col: 4, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 1, col: 5, row: 3, result: 'miss')
      expect(game.over?).to eq(false)
    end

    it 'returns true if last 5 guesses all match' do
      game = Game.create(word: 'apple', guess_no: 0, id: 1)
      Guess.create(value: 's', game_id: 1, col: 1, row: 1, result: 'miss')
      Guess.create(value: 'h', game_id: 1, col: 2, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 3, row: 1, result: 'occurs')
      Guess.create(value: 'f', game_id: 1, col: 4, row: 1, result: 'miss')
      Guess.create(value: 't', game_id: 1, col: 5, row: 1, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 1, row: 2, result: 'match')
      Guess.create(value: 'f', game_id: 1, col: 2, row: 2, result: 'miss')
      Guess.create(value: 't', game_id: 1, col: 3, row: 2, result: 'miss')
      Guess.create(value: 'e', game_id: 1, col: 4, row: 2, result: 'occurs')
      Guess.create(value: 'r', game_id: 1, col: 5, row: 2, result: 'miss')
      Guess.create(value: 'a', game_id: 1, col: 1, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 1, col: 2, row: 3, result: 'match')
      Guess.create(value: 'p', game_id: 1, col: 3, row: 3, result: 'match')
      Guess.create(value: 'l', game_id: 1, col: 4, row: 3, result: 'match')
      Guess.create(value: 'e', game_id: 1, col: 5, row: 3, result: 'match')
      expect(game.over?).to eq(true)
    end
  end
end
