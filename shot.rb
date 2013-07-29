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
    # An angle is passed when a shot is created, and this makes sure that the bullet follows that angle.
    @x += Gosu::offset_x(@angle, 1* @speed)
    @y += Gosu::offset_y(@angle, 1 * @speed)
  
    # This marks any bulle that has flown off the visible area as deleted, meaning it'll be destroyed next update cycle.
    if self.x > self.game.window.width or self.x < 0 or self.y > self.game.window.height or self.y < 0
      @deleted = true
    end
  end

  def draw
    # The simplest draw that there ever was.  Since all of the movement is handled above, just need to draw at x and y and done.
    @gfx.draw(@x,@y,1)
  end
end