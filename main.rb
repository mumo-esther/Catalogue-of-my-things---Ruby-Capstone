require_relative 'app'

class Main
  def initialize
    @app = App.new
  end

  def main_menu
    puts '-----------------------------'
    puts "Welcome to our catalog 👋\nSelect an option: 👉"
    puts '-----------------------------'
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List all games'
    puts '4 - List all genres'
    puts '5 - List all labels'
    puts '6 - List all authors'
    puts '7 - Add a new book'
    puts '8 - Add a new music album'
    puts '9 - Add a new game'
    puts '0 - Quit'
    puts '-----------------------------'
  end

  def run
    loop do
      main_menu
      option = gets.chomp
      case option
      when '1'
        @app.list_books
      when '2'
        @app.list_all_music_albums
      when '3'
        @app.list_games
      when '4'
        @app.list_all_genres
      when '5'
        @app.list_labels
      when '6'
        @app.list_authors
      else
        handle_add_option(option)
      end
    end
  end

  def handle_add_option(option)
    case option
    when '7'
      @app.add_book
    when '8'
      @app.add_music_album
    when '9'
      @app.add_game
    when '0'
      @app.close_app
      exit
    else
      puts 'Invalid option. Please try again.'
    end
  end
end

Main.new.run
