# Gosu is amazing, and using it is an amazing experience.
require 'gosu'

# Should clean these up at some point.
require './core.rb'
require './shot.rb'
require './bg.rb'
require './hud.rb'
require './player.rb'
require './enemy.rb'
require './explosion.rb'

# Our two gamestates.  'level2' is just a dummy at this point.
require './level1.rb'
require './level2.rb'

class Game < Gosu::Window
  def initialize
    # Several parts of the game are hard-coded for 640x480, will change.
    super 640,480,false
    self.caption = "Phalanx2 v#{VERSION}"
    @states = Array.new
    @states.push(Level1.new(self))
    @states.push(Level2.new(self))
    @current_state = 0
  end

  # Game doesn't actually use the mouse, but I don't like my cursor being hidden.
  def needs_cursor?
    true
  end

  def current_state
    @states[@current_state]
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    current_state.button_down(id)
  end

  def draw
    # Forward drawing to the current gamestate.
    current_state.draw
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
      current_state.left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight
      current_state.right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpUp
      current_state.up
    end
    if button_down? Gosu::KbDown or button_down? Gosu::GpDown
      current_state.down
    end
    if button_down? Gosu::KbSpace or button_down? Gosu::GpButton0
      current_state.space
    end

    unless button_down? Gosu::KbUp or button_down? Gosu::GpUp or button_down? Gosu::KbDown or button_down? Gosu::GpDown
      current_state.rest
    end

    # Forward updating to the current gamestate.
    current_state.update
  end
end

Game.new.show

