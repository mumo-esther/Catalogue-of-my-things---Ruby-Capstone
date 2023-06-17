require 'json'
class Label
  attr_accessor :title, :color, :items

  def initialize(title, color)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
  end

  def self.file_path
    './data/labels.json'
  end

  def self.load_collection
    return [] unless File.exist?(file_path)

    json_data = File.read(file_path)
    labels_data = JSON.parse(json_data)
    labels_data.map { |data| Label.new(data['title'], data['color']) }
  end

  def self.save_collection(labels)
    return unless labels.any?

    labels_data = labels.map { |label| { title: label.title, color: label.color } }
    json_data = JSON.generate(labels_data)
    File.write(file_path, json_data)
  end
end
