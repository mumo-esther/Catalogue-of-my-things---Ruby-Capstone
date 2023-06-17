require_relative '../catalog/music_album'
require_relative '../catalog/genre'
RSpec.describe MusicAlbum do
  let(:genre) { Genre.new('Comedy') }
  let(:title) { 'title' }
  let(:on_spotify) { true }
  let(:publish_date) { '2010-01-01' }
  subject { MusicAlbum.new(title, on_spotify, genre, publish_date) }
  describe '#new' do
    it 'takes four parameters and returns a MusicAlbum object' do
      expect(subject).to be_an_instance_of MusicAlbum
    end
  end
  describe '#title' do
    it 'Returns the correct title' do
      expect(subject.title).to eql title
    end
  end
  describe '#on_spotify' do
    it 'Returns the correct on_spotify' do
      expect(subject.on_spotify).to eql on_spotify
    end
  end
  describe '#Publish date' do
    it 'Returns the correct publish_date' do
      expect(subject.publish_date).to eql publish_date
    end
  end
  describe '#can_be_archived?' do
    context 'when super is true and on_spotify is true' do
      it 'Returns true' do
        expect(subject.can_be_archived?).to be(true)
      end
    end
  end
end
