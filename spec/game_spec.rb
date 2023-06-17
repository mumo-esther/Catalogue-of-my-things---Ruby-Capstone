require_relative '../catalog/game'
require_relative '../catalog/label'

describe Game do
  before :each do
    @label = Label.new('New', 'blue')
    @game = Game.new(true, '2018-01-23', @label, '1991-02-12')
  end

  it 'Checking Game instance' do
    expect(@game).to be_instance_of Game
  end

  it 'Returns the true for multiplayer' do
    expect(@game.multiplayer).to eql true
  end

  it 'Returns the correct last_played_at' do
    expect(@game.last_played_at).to eql '2018-01-23'
  end

  describe '#can_be_archived?' do
    context 'when super is true and last_played_at > 2' do
      it 'returns true' do
        expect(@game.can_be_archived?).to be(false)
      end
    end
  end
end
