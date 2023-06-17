require 'rspec'
require_relative '../catalog/book'
require_relative '../catalog/author'
describe Book do
  let(:author) { Author.new('Simon', 'Chowdery') }
  let(:book) { Book.new('New book', 'SK', 'good', author, 'Publisher') }
  it 'Checking Book instance' do
    expect(book).to be_instance_of Book
  end
  describe '#can_be_archived?' do
    context "when cover_state is 'good'" do
      it 'returns false' do
        expect(book.can_be_archived?).to be(false)
      end
    end
    context "when cover_state is 'bad'" do
      before { book.instance_variable_set(:@cover_state, 'bad') }
      it 'returns true' do
        expect(book.can_be_archived?).to be(true)
      end
    end
  end
end
