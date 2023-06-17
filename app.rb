# rubocop:disable Metrics/ClassLength

require_relative './catalog/label'
require_relative './catalog/book'
require_relative './catalog/game'
require_relative './catalog/author'
require_relative './catalog/music_album'
require_relative './catalog/genre'

class App
  attr_reader :labels, :books, :genres, :music_albums, :games, :authors

  def initialize
    @labels = Label.load_collection
    @books = Book.load_collection
    @genres = Genre.load_all
    @music_albums = MusicAlbum.load_all
    @games = Game.load_all
    @authors = Author.load_all
  end

  def list_labels
    @labels = Label.load_collection
    if @labels.empty?
      puts 'There are no labels available yet ❌!'
    else
      puts '🔖: Labels list:'
      @labels.each_with_index do |label, index|
        puts "[#{index + 1}] Title: #{label.title}, Color: #{label.color}"
      end
    end
  end

  def list_books
    @books = Book.load_collection
    if @books.empty?
      puts 'There are no books available yet :x:!'
    else
      puts '📖: Books list:'
      @books.each_with_index do |book, index|
        puts "[#{index + 1}] Title: #{book.title}, " \
             "Publisher: #{book.publisher}, " \
             "Author: #{book.author.first_name} #{book.author.last_name}, " \
             "Cover_State: #{book.cover_state}, " \
             "Archived: #{book.archived || (book.cover_state == 'bad')}"
      end
    end
  end

  def list_all_music_albums
    @music_albums = MusicAlbum.load_all
    if @music_albums.empty?
      puts 'There are no music albums available yet :x:!'
    else
      puts '📝: Music albums list:'
      @music_albums.each_with_index do |music_album, index|
        puts "[#{index + 1}] Title: #{music_album.title}, " \
             "Spotify: #{music_album.on_spotify}, " \
             "Genre: #{music_album.genre.name}, " \
             "Published: #{music_album.publish_date}, " \
             "Archived: #{music_album.archived}"
      end
    end
  end

  def list_all_genres
    @genres = Genre.load_all
    if @genres.empty?
      puts 'There are no genres available yet :x:!'
    else
      puts '📑: Genres list:'
      @genres.each_with_index do |genre, index|
        puts "[#{index + 1}] Name: #{genre.name}"
      end
    end
  end

  def list_games
    @games = Game.load_all
    if @games.empty?
      puts 'There are no games available yet :x:!'
    else
      puts '🏏: Games list:'
      @games.each_with_index do |game, index|
        puts "[#{index + 1}] Label: #{game.label.title}, " \
             "Last played at: #{game.last_played_at}, " \
             "Multiplayer: #{game.multiplayer}, " \
             "Publish date: #{game.publish_date}"
      end
    end
  end

  def list_authors
    @authors = Author.load_all
    if @authors.empty?
      puts 'There is no author available yet :x:!'
    else
      puts '👨‍🏫: Authors list:'
      @authors.each_with_index do |author, index|
        puts "[#{index + 1}] First name: #{author.first_name}, Last name: #{author.last_name}"
      end
    end
  end

  def add_book
    puts 'Enter book title:'
    title = gets.chomp
    puts 'Enter publisher:'
    publisher = gets.chomp
    puts 'Enter cover state (good/bad):'
    cover_state = gets.chomp.downcase == 'bad' ? 'bad' : 'good'
    puts 'Enter publish date (yyyy-mm-dd):'
    publish_date = gets.chomp
    author = select_author
    @books = Book.load_collection
    book = Book.new(title, publisher, cover_state, author, publish_date)
    book.add_author = (author)
    @books << book
    puts 'Book has been created successfully! :white_check_mark:'
    Book.save_collection(@books)
  end

  def add_label
    puts 'Enter label title:'
    title = gets.chomp
    puts 'Enter label color:'
    color = gets.chomp
    @labels = Label.load_collection
    label = Label.new(title, color)
    @labels << label
    Label.save_collection(@labels)
    label
  end

  def select_author
    puts "\nAdd the author information"
    puts 'First Name: '
    first_name = gets.chomp.to_s
    puts 'Last Name: '
    last_name = gets.chomp.to_s
    author = Author.new(first_name, last_name)
    @authors = Author.load_all
    @authors << author
    Author.save_all(@authors)
    author
  end

  def multiplayer_status
    puts 'Multiplayer? (Y/N): '
    multiplayer = gets.chomp.downcase
    case multiplayer
    when 'y'
      true
    when 'n'
      false
    else
      puts "Invalid value detected: #{multiplayer}"
    end
  end

  def add_game
    puts 'Publish Date: '
    publish_date = gets.chomp
    puts 'Select label: '
    label = add_label
    puts 'Date last played: '
    last_played = gets.chomp
    is_multiplayer = multiplayer_status
    new_game = Game.new(is_multiplayer, last_played, label, publish_date)
    new_game.add_label = (label)
    @games = Game.load_all
    @games << new_game
    Game.save_all(@games)
    puts 'Game has been created successfully! :white_check_mark:'
  end

  def add_genre(name)
    genre = Genre.new(name)
    @genres = Genre.load_all
    @genres << genre
    Genre.save_all(@genres)
    genre
  end

  def add_music_album
    puts 'Enter music album title:'
    title = gets.chomp
    puts 'Enter music album spotify status (true/false):'
    on_spotify = gets.chomp.downcase == 'true'
    puts 'Enter music album publish date (yyyy-mm-dd):'
    publish_date = gets.chomp
    puts 'Enter music album genre name:'
    genre_name = gets.chomp
    genre = add_genre(genre_name)
    music_album = MusicAlbum.new(title, on_spotify, genre, publish_date)
    music_album.add_genre = (genre)
    @music_albums = MusicAlbum.load_all
    @music_albums << music_album
    MusicAlbum.save_all(@music_albums)
    puts 'Music album has been created successfully! :white_check_mark:'
  end

  def close_app
    puts 'Thanks for using the app!'
  end
end
# rubocop:enable Metrics/ClassLength
