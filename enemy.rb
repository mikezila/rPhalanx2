class Enemy < GameObject
  
  attr_reader :x
  attr_reader :y

  def initialize(game,origin_x,origin_y)
    super game
    @tags.push("enemy_ship")
    @x = origin_x
    @y = origin_y
    @prev_shot = 0

    @shot_speed = 4
    @shot_freq = 500

    # The gfx_shot is passed to the Shot object, it isn't actually rendered by the enemy itself.
    @gfx_ship = Gosu::Image.new(self.game.window,"./gfx/enemy.png",false)
    @gfx_shot = Gosu::Image.new(self.game.window,"./gfx/enemy_shot.png",false)
  end

  def fire

    # This uses the players location to choose the angle to fire the shot at.  It will go in a straight line towards where the player was when the shot was fired.
    self.game.objects.each do |object|
      if object.tags.include? "player_ship"
        @angle = Gosu::angle(@x,@y,object.x,object.y)
        break
      end
    end

    # Throttle the shots, so the enemy isn't just going HAM the whole time.
    if Gosu::milliseconds - @prev_shot > @shot_freq
      self.game.objects.push(Shot.new(self.game,"enemy_shot",@gfx_shot,@x,@y+5,@angle,@shot_speed))
      @prev_shot = Gosu::milliseconds
    end
  end

  def update
    self.fire
  end

  def draw
    @gfx_ship.draw(@x,@y,2)
  end
end