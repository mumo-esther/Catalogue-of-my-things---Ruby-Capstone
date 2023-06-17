require_relative '../catalog/label'
RSpec.describe Label do
  let(:title) { 'Label 1' }
  let(:color) { 'Red' }
  let(:label) { Label.new(title, color) }
  describe '#new' do
    it 'takes two parameter and returns a Label object' do
      expect(label).to be_an_instance_of Label
    end
  end
  describe '#title' do
    it 'Should be return correct title' do
      expect(label.title).to eql title
    end
  end
  describe '#color' do
    it 'Should be return correct color' do
      expect(label.color).to eql color
    end
  end
  describe '#add_item' do
    let(:item) { double('Item') }
    it 'adds the item to the genre items' do
      expect { label.add_item(item) }.to change { label.items.length }.by(1)
    end
    it 'does not add the item if it is already added' do
      label.add_item(item)
      expect { label.add_item(item) }.not_to(change { label.items.length })
    end
  end
end
