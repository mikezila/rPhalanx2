class Level1 < GameState

  attr_reader :player

  def initialize(window)
    super window
    @hud = Hud.new(self)
    @bg = Background.new(self)
    @player = Player.new(self)
    @objects.push(@hud)
    @objects.push(@bg)
    @objects.push(@player)
    self.place_enemy # Setup our test enemies.
  end

  def button_down(id)
    super
    if id == Gosu::KbB
      @player.boost_change
    end
  end

  def left
    @player.left
  end

  def right
    @player.right
  end

  def up
    @player.up
  end

  def down
    @player.down
  end

  def space
    @player.fire
  end

  def rest
    @player.rest
  end

  def place_enemy
    # These dummies are just for testing, they stand and fire, nothing else.
    self.objects.push(Enemy.new(self,450,140))
    self.objects.push(Enemy.new(self,450,180))
    self.objects.push(Enemy.new(self,450,220))
    self.objects.push(Enemy.new(self,450,260))
    self.objects.push(Enemy.new(self,450,300))
  end

  # Used to stress-test, spawns a ton of enemies that all stand and fire.
  def place_swarm
    x = 150
    y = 10
    spacing = 20
    250.times do
      self.objects.push(Enemy.new(self,x,y))
      y += spacing
      if y > self.window.height - 30
        y = 10
        x += 40
      end
    end
  end

  def update
    super
  end

  def draw
    super
  end
end
