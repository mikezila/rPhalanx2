class Player < GameObject

  attr_reader :x
  attr_reader :y
  attr_reader :boost
  attr_reader :health
  attr_reader :shots

  def initialize(game)
    super game
    @gfx_ship = Gosu::Image.load_tiles(game.window,"./gfx/ship.png",22,16,false)
    @gfx_shot = Gosu::Image.new(game.window,"./gfx/shot.png",false)
    @tags.push("player_ship")
    @state = 2
    @boost = 3
    @health = 3
    @x = game.window.width / 4
    @y = game.window.height / 2
    @prev_shot = 0
    @shots_budget = 6
    @shots = Array.new
  end

  # Looks complicated, but isn't.  Lets us fire every 60 milliseconds, but only if we're under budget for how many shots we're allowed.
  def fire
    if Gosu::milliseconds - @prev_shot > 60
      shots.push(Shot.new(game,"player_shot",@gfx_shot,@x+8,@y,90,10)) unless @live_shots >= @shots_budget
      @prev_shot = Gosu::milliseconds
    end
  end

  # This is called whenever there are no movement buttons held down, so that the ship returns to a neutral position after animating going up/down.
  def rest
    if @state > 2
      @state -= 1
    elsif @state < 2
      @state += 1
    end
  end

  # Keep track of the number of live player shots, so we can throttle how many we're allowed at once.
  def update
    @live_shots = shots.length
    shots.each do |shot|
      shot.update
    end
    shots.delete_if do |shot|
      shot.deleted?
    end

    game.objects.each do |object|
      if object.tags.include? "enemy_shot"
        if Gosu::distance(object.x,object.y,@x,@y) < 10
          @health -= 1
          object.delete
        end
      end
    end
  end

  # This cycles our boost between three levels.
  def boost_change
    if @boost == 5
      @boost = 3
    else
      @boost += 1
    end
  end

  # Some pretty simple movement methods.
  def up
    @state -= 1 unless @state == 0
    @y -= 1 * @boost
  end

  def down
    @state += 1 unless @state == 4
    @y += 1 * @boost
  end

  def left
    @x -= 1 * @boost
  end

  def right
    @x += 1 * @boost
  end

  # Simple draw method, the @state is used to pick the sprite from our array according to our animation state.
  def draw
    @gfx_ship[@state].draw_rot(@x,@y,Zorder::Player,0)
    shots.each do |shot|
      shot.draw
    end
  end
end
