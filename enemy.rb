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
    @shot_freq = 1500

    # The gfx_shot is passed to the Shot object, it isn't actually rendered by the enemy itself.
    @gfx_ship = Gosu::Image.new(self.game.window,"./gfx/enemy.png",false)
    @gfx_shot = Gosu::Image.new(self.game.window,"./gfx/enemy_shot.png",false)
  end

  def fire

    # This uses the players location to choose the angle to fire the shot at.  It will go in a straight line towards where the player was when the shot was fired.
    @angle = Gosu::angle(@x-18,@y-5,self.game.player.x,self.game.player.y)

    # Throttle the shots, so the enemy isn't just going HAM the whole time.  Variables for this are set in the contstructor.
    if Gosu::milliseconds - @prev_shot > @shot_freq
      self.game.objects.push(Shot.new(self.game,"enemy_shot",@gfx_shot,@x-18,@y-5,@angle,@shot_speed))
      @prev_shot = Gosu::milliseconds
    end
  end

  # Try to fire every frame, the fire method will handle the throttling.
  def update
    self.fire

    self.game.player.shots.each do |object|
      if Gosu::distance(self.x,self.y,object.x,object.y) < 10
        self.delete
        object.delete
        self.game.objects.push(Explosion.new(self.game,object.x,object.y))
      end
    end
  end

  # Simple draw.
  def draw
    @gfx_ship.draw_rot(@x,@y,Zorder::Enemy,0)
  end
end