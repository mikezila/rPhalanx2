class Background < GameObject

  attr_accessor :x
  attr_accessor :y
  attr_accessor :scroll_speed
  attr_accessor :paralax

  def initialize(game)
    super game
    window = self.game.window
    gfx1 = Gosu::Image.new(window,"./gfx/bg1.png",false)
    gfx2 = Gosu::Image.new(window,"./gfx/bg2.png",false)
    gfx3 = Gosu::Image.new(window,"./gfx/bg3.png",false)
    @x = @y = 0
    @scroll_speed = 2
    @paralax = true

    @layers = Array.new
    @layers.push Layer.new(0,0,gfx1,1)
    @layers.push Layer.new(0,230,gfx2,2)
    @layers.push Layer.new(0,346,gfx3,3)
  end


  def draw
    @layers.each do |layer|
      layer.draw
    end
  end


  def update
    @layers.each do |layer|
      layer.update
    end
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
    @gfx.draw(@x,@y,0)
    @gfx.draw(@x+640,@y,0)
  end

  def update
    @scroll_speed.times do
      @x = -1 if @x == -640
      @x -= 1
    end
  end
end