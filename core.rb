DEBUG = true
VERSION = 0.7

def debug(message)
  puts "#{Time.now.strftime("%H:%M:%S.%L")} - \t#{message}" if DEBUG
end

class GameObject

  attr_reader :game
  attr_reader :tags

  def initialize(game)
    @game = game
    @tags = Array.new
    @deleted = false
  end

  def draw
  end

  def update
  end

  def deleted?
    @deleted
  end
end

class GameState

  attr_reader :objects
  attr_reader :window

  def initialize(window)
    @window = window
    @objects = Array.new
  end

  def button_down(id)
    nil
  end

  def update
    self.objects.each do |object|
      object.update
    end
    self.objects.delete_if do |object|
      object.deleted?
    end
  end

  def draw
    self.objects.each do |object|
      object.draw
    end
  end
end
