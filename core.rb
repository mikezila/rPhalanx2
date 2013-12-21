DEBUG = true
VERSION = 0.7

def debug(message)
  puts "#{Time.now.strftime("%H:%M:%S.%L")} - \t#{message}" if DEBUG
end

# All objects in the game extend from this class, without exception.  The tags array contains strings that describe the object, and are used to find it and objects like it when doing callbacks on all objects.  This makes it easy to send callbacks to some gameobjects, but not others, and to interact with all objects or just the ones you want without having to keep seperate arrays or use controller classes for each time.
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

  def delete
    @deleted = true
  end

  def deleted?
    @deleted
  end
end


#All game objects are pushed into the "objects" array, without exception.  All objects in this array have update and draw called on them, and are deleted if they have their "deleted?" flag set.  I also store references to the Gosu window and the objects array for ease of making new graphics and so that objects can do callbacks on all other objects via self.game.objects
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
    objects.each do |object|
      object.update
    end
    objects.delete_if do |object|
      object.deleted?
    end
  end

  def draw
    objects.each do |object|
      object.draw
    end
  end
end

module Zorder
  Background = 0
  Enemy = 1
  Player = 2
  Shot = 3
  Effects = 4
  HUD = 5
end
