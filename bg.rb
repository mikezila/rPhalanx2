# These two classes form a pretty basic but extensible paralax background scroller.  Simple, but works pretty well.

class Background < GameObject

  def initialize(game)
    super game
    window = game.window
    gfx1 = Gosu::Image.new(window,"./gfx/bg1.png",false)
    gfx2 = Gosu::Image.new(window,"./gfx/bg2.png",false)
    gfx3 = Gosu::Image.new(window,"./gfx/bg3.png",false)
    @x = @y = 0

    @layers = Array.new
    @layers.push Layer.new(0,0,gfx1,1)
    @layers.push Layer.new(0,230,gfx2,2)
    @layers.push Layer.new(0,346,gfx3,3)
  end


  def draw
    @layers.each &:draw
  end


  def update
    @layers.each &:update
  end
end

class Layer

  attr_accessor :y

  def initialize(x,y,gfx,scroll_speed)
    @x = x
    @y = y
    @gfx = gfx
    @scroll_speed = scroll_speed
  end

  def draw
    @gfx.draw(@x,@y,Zorder::Background)
    @gfx.draw(@x+640,@y,Zorder::Background)
  end

  def update
    @scroll_speed.times do
      @x = -1 if @x == -640
      @x -= 1
    end
  end
end