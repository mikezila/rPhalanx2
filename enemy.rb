class Enemy < GameObject
  
  attr_accessor :x
  attr_accessor :y

  def initialize(game,origin_x,origin_y)
    super game
    @tags.push("enemy_ship")
    @x = origin_x
    @y = origin_y
    @prev_shot = 0

    @shot_speed = 4
    @shot_freq = 1300

    @gfx_ship = Gosu::Image.new(self.game.window,"./gfx/enemy.png",false)
    @gfx_shot = Gosu::Image.new(self.game.window,"./gfx/enemy_shot.png",false)
  end

  def fire

    self.game.objects.each do |object|
      if object.tags.include? "player_ship"
        @angle = Gosu::angle(@x,@y,object.x,object.y)
      end
    end

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