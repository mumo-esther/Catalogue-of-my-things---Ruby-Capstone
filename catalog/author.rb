class Author
  attr_reader :id
  attr_accessor :first_name, :last_name, :items

  def initialize(first_name, last_name)
    @id = Random.rand(1..1000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item unless item_already_added?(item)
  end

  def self.file_path
    './data/author.json'
  end

  def self.load_all
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    author_data = JSON.parse(file_content)
    author_data.map { |data| Author.new(data['first_name'], data['last_name']) }
  end

  def self.save_all(authors)
    return unless authors.any?

    author_data = authors.map { |author| { first_name: author.first_name, last_name: author.last_name } }
    File.write(file_path, JSON.pretty_generate(author_data))
  end

  private

  def item_already_added?(item)
    @items.include?(item)
  end
end
