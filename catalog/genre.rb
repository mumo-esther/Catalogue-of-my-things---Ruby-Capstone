require 'json'
require_relative 'item'
class Genre
  attr_reader :id, :name, :items

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
  end

  def self.file_path
    './data/genres.json'
  end

  def self.load_all
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    genre_data = JSON.parse(file_content)
    genre_data.map { |data| Genre.new(data['name']) }
  end

  def self.save_all(genres)
    return unless genres.any?

    genre_data = genres.map { |genre| { name: genre.name } }
    File.write(file_path, JSON.pretty_generate(genre_data))
  end
end
