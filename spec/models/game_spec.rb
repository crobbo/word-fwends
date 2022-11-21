require 'rails_helper'
require 'factories/game'
require 'factories/guess'
require 'factories/player'

RSpec.describe Game, type: :model do
  before(:each) do
    @game = create(:game)
  end

  describe '#last guess' do
    context 'when there are no word guesses' do
      subject { @game.last_guess }
      it { is_expected.to eq([]) }
    end

    context 'when there is one or more word guess' do
      it 'returns the last guess' do
        first_word_guess = create_guesses(0)
        expect(@game.last_guess).to eq(first_word_guess)
      end

      it 'returns the last guess' do
        create_guesses(5)
        second_word_guess = create_guesses(5)
        expect(@game.last_guess).to eq(second_word_guess)
      end

      it 'returns the last guess' do
        create_guesses(10)
        third_word_guess = create_guesses(5)
        expect(@game.last_guess).to eq(third_word_guess)
      end

      private

      def create_guesses(num)
        guesses = []

        num.times do
          guesses << create(:guess, game_id: @game.id)
        end

        guesses
      end
    end
  end

  describe '#last_guess_string' do
    context 'when there are no word guesses' do
      before do
        @word_guess = []
      end

      it 'returns empty string' do
        expect(@game.last_guess_string(@word_guess)).to eq('')
      end
    end

    context 'when there is one or more word guess' do
      it 'returns a 5 character string' do
        first_word_guess = create_guesses_with_word(5, 'hello')
        expect(@game.last_guess_string(first_word_guess)).to eq('hello')
      end

      it 'returns a 5 character string' do
        create_guesses_with_word(5, 'hello')
        second_word_guess = create_guesses_with_word(5, 'world')
        expect(@game.last_guess_string(second_word_guess)).to eq('world')
      end

      private

      def create_guesses_with_word(num, word)
        guesses = []
        i = 0
        num.times do
          guesses << create(:guess, game_id: @game.id, value: word[i])
          i += 1
        end

        guesses
      end
    end
  end

  # describe '#clear_last_guess' do
  #   before(:each) do
  #     @game = create(:game)
  #   end

  #   context 'when there is one word guess' do
  #     it 'return empty values' do
  #       first_word_guess = create_guesses_with_word(5, 'hello')
  #       @game.clear_last_guess
  #       expect(@game.last_guess_string(first_word_guess)).to eq('')
  #     end
  #   end

  #   private

  #   def create_guesses_with_word(num, word)
  #     guesses = []
  #     i = 0
  #     num.times do
  #       guesses << create(:guess, game_id: @game.id, value: word[i])
  #       i += 1
  #     end

  #     guesses
  #   end
  # end

  describe '#check_letter' do
    context 'when letter matches' do
      it 'returns match' do
        expect(@game.check_letter('a', 0, 1)).to eq('match')
      end

      it 'returns match' do
        expect(@game.check_letter('p', 1, 1)).to eq('match')
      end

      it 'returns match' do
        expect(@game.check_letter('p', 2, 1)).to eq('match')
      end

      it 'returns match' do
        expect(@game.check_letter('l', 3, 1)).to eq('match')
      end

      it 'returns match' do
        expect(@game.check_letter('e', 4, 1)).to eq('match')
      end
    end

    context 'when letter occurs' do
      it 'returns occurs' do
        expect(@game.check_letter('p', 0, 1)).to eq('occurs')
      end

      it 'returns occurs' do
        expect(@game.check_letter('e', 1, 1)).to eq('occurs')
      end

      it 'returns occurs' do
        expect(@game.check_letter('l', 2, 1)).to eq('occurs')
      end

      it 'returns occurs' do
        expect(@game.check_letter('p', 3, 1)).to eq('occurs')
      end

      it 'returns occurs' do
        expect(@game.check_letter('a', 4, 1)).to eq('occurs')
      end
    end

    context 'when letter misses' do
      it 'returns miss' do
        expect(@game.check_letter('b', 0, 1)).to eq('miss')
      end

      it 'returns miss' do
        expect(@game.check_letter('o', 1, 1)).to eq('miss')
      end

      it 'returns miss' do
        expect(@game.check_letter('o', 2, 1)).to eq('miss')
      end

      it 'returns miss' do
        expect(@game.check_letter('s', 3, 1)).to eq('miss')
      end

      it 'returns miss' do
        expect(@game.check_letter('t', 4, 1)).to eq('miss')
      end
    end
  end

  describe '#letter_count' do
    context 'when letter is not contained within word' do
      it 'returns zero' do
        expect(@game.letter_count('b')).to eq(0)
      end
    end

    context 'when letter is contained within word' do
      it 'returns one' do
        expect(@game.letter_count('a')).to eq(1)
      end

      it 'returns two' do
        expect(@game.letter_count('p')).to eq(2)
      end
    end
  end

  describe '#prev_guess_count' do
    context 'when letter is not contained in a previous word guess' do
      it 'returns zero' do
        expect(@game.prev_guess_count('a', 1)).to eq(0)
      end
    end

    context 'when letter is contained in a previous word guess' do
      it 'returns one' do
        create_guesses_with_word(5, 'hello')
        expect(@game.prev_guess_count('h', 1)).to eq(1)
      end

      it 'returns two' do
        create_guesses_with_word(5, 'hello')
        expect(@game.prev_guess_count('l', 1)).to eq(2)
      end
    end

    private

    def create_guesses_with_word(num, word)
      guesses = []
      i = 0

      num.times do
        guesses << create(:guess, game_id: @game.id, value: word[i], row: 1, col: i)
        i += 1
      end

      guesses
    end
  end

  describe '#check_exact_match?' do
    context 'when letter is not an exact match' do
      it 'returns false' do
        expect(@game.check_exact_match?('a', 2)).to eq(false)
      end

      it 'returns false' do
        expect(@game.check_exact_match?('p', 4)).to eq(false)
      end

      it 'returns false' do
        expect(@game.check_exact_match?('g', 3)).to eq(false)
      end
    end

    context 'when letter is an exact match' do
      it 'returns true' do
        expect(@game.check_exact_match?('a', 0)).to eq(true)
      end

      it 'returns true' do
        expect(@game.check_exact_match?('p', 2)).to eq(true)
      end

      it 'returns true' do
        expect(@game.check_exact_match?('e', 4)).to eq(true)
      end
    end

    describe '#check_partial_match' do
      context 'when letter exists and is in the wrong place and has been guessed already' do
        it 'returns miss' do
          create_guesses_with_word(3, 'lit')
          expect(@game.check_partial_match('l', 1)).to eq('miss')
        end

        it 'returns miss' do
          create_guesses_with_word(3, 'sal')
          expect(@game.check_partial_match('a', 1)).to eq('miss')
        end
      end

      context 'when letter exists and is in the wrong place and has not been guessed already' do
        it 'returns occurs' do
          create_guesses_with_word(2, 'si')
          expect(@game.check_partial_match('l', 1)).to eq('occurs')
        end

        it 'returns occurs' do
          create_guesses_with_word(2, 'grou')
          expect(@game.check_partial_match('p', 1)).to eq('occurs')
        end
      end

      private

      def create_guesses_with_word(num, word)
        guesses = []
        i = 0

        num.times do
          guesses << create(:guess, game_id: @game.id, value: word[i], row: 1, col: i)
          i += 1
        end

        guesses
      end
    end
  end

  describe '#win?' do
    context 'when game is not won' do
      it 'returns false' do
        create_guesses_with_word(5, 'hello', 'miss')
        expect(@game.win?).to eq(false)
      end
    end

    context 'when game is won' do
      it 'returns true' do
        create_guesses_with_word(5, 'hello', 'match')
        expect(@game.win?).to eq(true)
      end
    end

    private

    def create_guesses_with_word(num, word, result)
      guesses = []
      i = 0

      num.times do
        guesses << create(:guess, game_id: @game.id, value: word[i], row: 1, col: i, result: result)
        i += 1
      end

      guesses
    end
  end

  describe '#matches?' do
    context 'when there are no matches previously guessed ' do
      it 'returns false' do
        create(:guess, game_id: @game.id, value: 'a', result: 'miss')
        expect(@game.matches?('a')).to eq(false)
      end
    end

    context 'when there are matches previously guessed' do
      it 'returns true' do
        create(:guess, game_id: @game.id, value: 'a', result: 'match')
        expect(@game.matches?('a')).to eq(true)
      end
    end
  end

  describe '#occurances?' do
    context 'when there are no occurances previously guessed' do
      it 'returns false' do
        create(:guess, game_id: @game.id, value: 'a', result: 'miss')
        expect(@game.occurances?('a')).to eq(false)
      end
    end

    context 'when there are occurances previously guessed' do
      it 'returns true' do
        create(:guess, game_id: @game.id, value: 'a', result: 'occurs')
        expect(@game.occurances?('a')).to eq(true)
      end
    end
  end

  describe '#misses?' do
    context 'when there are no misses previously guessed' do
      it 'returns false' do
        create(:guess, game_id: @game.id, value: 'a', result: 'match')
        expect(@game.misses?('a')).to eq(false)
      end
    end

    context 'when there are misses previously guessed' do
      it 'returns true' do
        create(:guess, game_id: @game.id, value: 'a', result: 'miss')
        expect(@game.misses?('a')).to eq(true)
      end
    end
  end

  describe '#find_player' do
    it 'returns player one' do
      player_one = create(:player, player_no: 1, game_id: @game.id)
      create(:player, player_no: 2, game_id: @game.id)
      expect(@game.find_player(1)).to eq(player_one)
    end

    it 'returns player two' do
      create(:player, player_no: 1, game_id: @game.id)
      player_two = create(:player, player_no: 2, game_id: @game.id)
      expect(@game.find_player(2)).to eq(player_two)
    end
  end

  describe '#check_player_two?' do
    context 'when player is player two' do
      it 'returns true' do
        player_two = create(:player, player_no: 2, game_id: @game.id)
        expect(@game.check_player_two?(player_two.id)).to eq(true)
      end
    end

    context 'when player is not player two' do
      it 'returns false' do
        player_one = create(:player, player_no: 1, game_id: @game.id)
        expect(@game.check_player_two?(player_one.id)).to eq(false)
      end
    end
  end
end