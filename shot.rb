class Shot < GameObject

  attr_reader :x
  attr_reader :y
  attr_reader :angle
  attr_reader :speed
  attr_reader :tag

  def initialize(game,tag,gfx,origin_x,origin_y,angle,speed)
    super game
    @tags.push("shot")
    @tags.push(tag.to_s)
    @speed = speed
    @x = origin_x
    @y = origin_y
    @angle = angle
    @speed = speed
    @gfx = gfx
  end

  def update
    @speed.times do
      @x += Gosu::offset_x(@angle, 1)
      @y += Gosu::offset_y(@angle, 1)
    end
  
    if self.x > self.game.window.width or self.x < 0 or self.y > self.game.window.height or self.y < 0 or self.deleted?
      @deleted = true
    end
  end

  def draw
    @gfx.draw(@x,@y,1)
  end

  def to_s
    return "X:#{@x} Y:#{@y}"
  end
end