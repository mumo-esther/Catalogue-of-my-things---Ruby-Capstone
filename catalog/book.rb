require 'json'
require_relative 'item'
require_relative 'author'
class Book < Item
  attr_reader :author
  attr_accessor :title, :cover_state, :publisher

  def initialize(title, publisher, cover_state, author, publish_date)
    super(publish_date)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
    @author = author
  end

  def can_be_archived?
    @cover_state == 'bad'
  end

  def self.file_path
    './data/books.json'
  end

  def self.get_author(data)
    Author.new(data['author']['first_name'], data['author']['last_name'])
  end

  def self.load_collection
    return [] unless File.exist?(file_path)

    json_data = File.read(file_path)
    books_data = JSON.parse(json_data)
    books_data.map do |data|
      Book.new(data['title'], data['publisher'], data['cover_state'], Book.get_author(data), data['publish_date'])
    end
  end

  def self.save_collection(books)
    return unless books.any?

    books_data = books.map do |book|
      {
        title: book.title,
        publisher: book.publisher,
        cover_state: book.cover_state,
        author: {
          first_name: book.author.first_name,
          last_name: book.author.last_name
        },
        publish_date: book.publish_date
      }
    end
    json_data = JSON.generate(books_data)
    File.write(file_path, json_data)
  end
end
