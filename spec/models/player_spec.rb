require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'returns name with correct capitilization' do
    player = Player.create(name: 'cHrisTiaN', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', player_no: 1)
    expect(player.capitalize_name).to eq('Christian')
  end

  it 'returns name with correct capitilization' do
    player = Player.create(name: 'christian', game_id: 'ef1cc52f-f4fb-46ed-a017-37569bd14c9a', player_no: 1)
    expect(player.capitalize_name).to eq('Christian')
  end
end
