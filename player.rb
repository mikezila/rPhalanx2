class Player < GameObject

  attr_reader :x
  attr_reader :y
  attr_reader :boost
  attr_reader :health

  def initialize(game)
    super game
    @gfx_ship = Gosu::Image.load_tiles(self.game.window,"./gfx/ship.png",22,16,false)
    @gfx_shot = Gosu::Image.new(game.window,"./gfx/shot.png",false)
    @tags.push("player_ship")
    @state = 2
    @boost = 2
    @health = 3
    @x = self.game.window.width / 4
    @y = self.game.window.height / 2
    @prev_shot = 0
    @shots_budget = 4
  end

  # Looks complicated, but isn't.  Lets us fire every 60 milliseconds, but only if we're under budget for how many shots we're allowed.
  def fire
    if Gosu::milliseconds - @prev_shot > 60
      self.game.objects.push(Shot.new(self.game,"player_shot",@gfx_shot,@x+22,@y+6,90,10)) unless @live_shots >= @shots_budget
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
    @live_shots = 0
    self.game.objects.each do |object|
      if object.tags.include? "player_shot"
        @live_shots += 1
      end 
    end

    self.game.objects.each do |object|
      if object.tags.include? "enemy_shot"
        if Gosu::distance(object.x,object.y,@x,@y) < 10
          @health -= 1
        end
      end
    end
  end

  # This cycles our boost between three levels.
  def boost_change
    if @boost == 4
      @boost = 2
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

  def draw
    @gfx_ship[@state].draw(@x,@y,1)
  end
end
