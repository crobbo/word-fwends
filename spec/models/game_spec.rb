require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'Updating game state' do
    it 'should add letter to game state' do
      game = Game.create(word: 'test', state: '')
      game.guess!('T')
      expect(game.state).to eq('T')
    end

    it 'should remove letter from game state' do
      game = Game.create(word: 'test', state: 'ABCDEF')
      game.undo_guess!
      expect(game.state).to eq('ABCDE')
    end

    it 'should remove letter from game state when only a sinlge charcater in state' do
      game = Game.create(word: 'test', state: 'A')
      game.undo_guess!
      expect(game.state).to eq('')
    end

    it 'should return empty string when game state is empty' do
      game = Game.create(word: 'test', state: '')
      game.undo_guess!
      expect(game.state).to eq('')
    end

    it 'returns current guess' do
      game = Game.create(word: 'test', state: 'ABCDEF')
      expect(game.current_guess).to eq('F')
    end

    it 'returns current guess' do
      game = Game.create(word: 'test', state: 'AASFDSGDFGNTHHAERFER')
      expect(game.current_guess).to eq('R')
    end

    it 'game state is not altered after calling current_guess' do
      game = Game.create(word: 'test', state: 'AASFDSGDFGNTHHAERFER')
      game.current_guess
      expect(game.state).to eq('AASFDSGDFGNTHHAERFER')
    end
  end

  context 'Check if letter is in word' do
    it 'should return true if letter is in word' do
      game = Game.create(word: 'excellent', state: '')
      expect(game.includes_letter?('e')).to eq(true)
    end

    it 'should return true if letter is in word' do
      game = Game.create(word: 'excellent', state: '')
      expect(game.includes_letter?('t')).to eq(true)
    end

    it 'should return true if letter is in word AND capital letter' do
      game = Game.create(word: 'excellent', state: '')
      expect(game.includes_letter?('X')).to eq(true)
    end

    it 'should return false if letter is NOT in word' do
      game = Game.create(word: 'excellent', state: '')
      expect(game.includes_letter?('z')).to eq(false)
    end
  end

  context 'find row of guess' do
    it 'return row of guess when guess is in first row' do
      game = Game.create(word: 'test', state: 'ADASD')
      expect(game.return_row(game.state.length)).to eq(1)
    end

    it 'return row of guess when guess is in first row' do
      game = Game.create(word: 'test', state: 'A')
      expect(game.return_row(game.state.length)).to eq(1)
    end

    it 'return row of guess when guess is in second row' do
      game = Game.create(word: 'test', state: 'ADASDD')
      expect(game.return_row(game.state.length)).to eq(2)
    end

    it 'return row of guess when guess is in second row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLD')
      expect(game.return_row(game.state.length)).to eq(2)
    end

    it 'return row of guess when guess is in third row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDH')
      expect(game.return_row(game.state.length)).to eq(3)
    end

    it 'return row of guess when guess is in third row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGF')
      expect(game.return_row(game.state.length)).to eq(3)
    end
    it 'return row of guess when guess is in fourth row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGFF')
      expect(game.return_row(game.state.length)).to eq(4)
    end
    it 'return row of guess when guess is in fourth row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGFFFFFF')
      expect(game.return_row(game.state.length)).to eq(4)
    end

    it 'return row of guess when guess is in fifth row' do
      game = Game.create(word: 'test', state: 'DASDHJKLDHYTGFFFFFFSD')
      expect(game.return_row(game.state.length)).to eq(5)
    end
    it 'return row of guess when guess is in fifth row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGFFFFFFDDDDD')
      expect(game.return_row(game.state.length)).to eq(5)
    end

    it 'return row of guess when guess is in sixth row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGFFFFFFDDDDDDE')
      expect(game.return_row(game.state.length)).to eq(6)
    end
    it 'return row of guess when guess is in sixth row' do
      game = Game.create(word: 'test', state: 'ADASDHJKLDHYTGFFFFFFDDDDDDDD')
      expect(game.return_row(game.state.length)).to eq(6)
    end
  end

  context 'find index of guess' do
    it 'return index of guess when guess is in first row' do
      game = Game.create(word: 'space', state: 'SCA')
      expect(game.return_index).to eq(2)
    end

    it 'return index of guess when guess is in first row' do
      game = Game.create(word: 'space', state: 'S')
      expect(game.return_index).to eq(0)
    end

    it 'return index of guess when guess is in first row' do
      game = Game.create(word: 'space', state: 'SCARE')
      expect(game.return_index).to eq(4)
    end

    it 'return index of guess when guess is in second row' do
      game = Game.create(word: 'space', state: 'SCAREF')
      expect(game.return_index).to eq(0)
    end

    it 'return index of guess when guess is in second row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCK')
      expect(game.return_index).to eq(4)
    end

    it 'return index of guess when guess is in third row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSH')
      expect(game.return_index).to eq(1)
    end

    it 'return index of guess when guess is in third row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHIN')
      expect(game.return_index).to eq(3)
    end

    it 'return index of guess when guess is in fourth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINESOCKS')
      expect(game.return_index).to eq(4)
    end

    it 'return index of guess when guess is in fourth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINESO')
      expect(game.return_index).to eq(1)
    end

    it 'return index of guess when guess is in fifth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINEKICKSTE')
      expect(game.return_index).to eq(1)
    end

    it 'return index of guess when guess is in fifth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINEKICKSTEAR')
      expect(game.return_index).to eq(3)
    end

    it 'return index of guess when guess is in sixth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINEKICKSTEARST')
      expect(game.return_index).to eq(0)
    end

    it 'return index of guess when guess is in sixth row' do
      game = Game.create(word: 'space', state: 'SCAREFLOCKSHINEKICKSTEARSTRU')
      expect(game.return_index).to eq(2)
    end
  end

  context 'check if guess matches' do
    it 'return true if guess is exact match' do
      game = Game.new(word: 'space', state: 'SP')
      expect(game.letter_match?('P')).to eq(true)
    end

    it 'return true if guess is exact match' do
      game = Game.new(word: 'space', state: 'SO')
      expect(game.letter_match?('O')).to eq(false)
    end
  end
end
