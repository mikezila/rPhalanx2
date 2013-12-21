class Enemy < GameObject
  
  attr_reader :x
  attr_reader :y

  def initialize(game,origin_x,origin_y)
    super game
    @tags.push("enemy_ship")
    @x = origin_x
    @y = origin_y
    @prev_shot_time = 0
    @move_speed = 2

    @shot_speed = 3
    @shot_freq = 1800

    # The gfx_shot is passed to the Shot object, it isn't actually rendered by the enemy itself.
    @gfx_ship = Gosu::Image.new(game.window,"./gfx/enemy.png",false)
    @gfx_shot = Gosu::Image.new(game.window,"./gfx/enemy_shot.png",false)
  end

  def fire

    # This uses the players location to choose the angle to fire the shot at.  It will go in a straight line towards where the player was when the shot was fired.
    @angle = Gosu::angle(@x-18,@y-5,game.player.x,game.player.y)

    # Throttle the shots, so the enemy isn't just going HAM the whole time.  Variables for this are set in the contstructor.
    if Gosu::milliseconds - @prev_shot_time > @shot_freq
      game.objects.push(Shot.new(game,"enemy_shot",@gfx_shot,@x-18,@y-5,@angle,@shot_speed))
      @prev_shot_time = Gosu::milliseconds
    end
  end

  def update

    # Mark ourselves as deleted if we're off the left side of the screen.
    delete if @x < -15

    # Try to fire every frame, the fire method will handle the throttling.
    fire

    # Try to get level with the player.
    if y > game.player.y
      @y -= 1 * @move_speed / 2 unless x <= game.window.width / 2
    elsif y < game.player.y
      @y += 1 * @move_speed / 2 unless x <= game.window.width / 2
    end

    @x -= 1 * @move_speed

    # Check to see if we're hit, and if so, kill ourselves and the bullet that hit us, and leave behind an explosion. Boom!
    game.player.shots.each do |object|
      if Gosu::distance(x,y,object.x,object.y) < 20
        delete
        object.delete
        game.objects.push(Explosion.new(game,object.x,object.y))
      end
    end
  end

  # Simple draw.
  def draw
    @gfx_ship.draw_rot(@x,@y,Zorder::Enemy,0)
  end
end