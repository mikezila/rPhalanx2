# This gamestate is just a dummy, an empty, scrolling background.  Just to test gamestates were working, which they are.

class Level2 < GameState
  def initialize(window)
    super window
    @gfx = Gosu::Image.new(window,'./gfx/bg.png',false)
    @x = 0
  end

  def update
    @x = 0 if @x == 640
    @x += 1
  end

  def draw
    @gfx.draw(@x,0,0)
    @gfx.draw(@x-640,0,0)
  end
end