require 'json'
require_relative 'item'
require_relative 'genre'
class MusicAlbum < Item
  attr_reader :genre
  attr_accessor :on_spotify, :title, :publish_date

  def initialize(title, on_spotify, genre, publish_date)
    super(publish_date)
    @on_spotify = on_spotify
    @genre = genre
    @publish_date = publish_date
    @title = title
  end

  def can_be_archived?
    return true if super && @on_spotify == true

    false
  end

  def self.file_path
    './data/music_albums.json'
  end

  def self.load_all
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    albums_data = JSON.parse(file_content)
    albums_data.map do |data|
      MusicAlbum.new(data['title'], data['on_spotify'], Genre.new(data['genre']), data['publish_date'])
    end
  end

  def self.save_all(music_albums)
    return unless music_albums.any?

    data = music_albums.map do |album|
      {
        title: album.title,
        on_spotify: album.on_spotify,
        genre: album.genre.name,
        publish_date: album.publish_date
      }
    end
    File.write(file_path, JSON.pretty_generate(data))
  end
end
