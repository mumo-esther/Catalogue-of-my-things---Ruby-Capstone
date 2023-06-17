require 'date'

class Item
  attr_reader :id, :genre, :source, :author, :label, :archived
  attr_accessor :publish_date

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    age_in_years >= 10
  end

  def add_genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def add_author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def add_label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def move_to_archive
    @archived = can_be_archived?
  end

  private

  def age_in_years
    Date.today.year - Date.parse(@publish_date).year
  end
end
