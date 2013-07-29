class Level1 < GameState

  def initialize(window)
    super window
    @hud = Hud.new(self)
    @bg = Background.new(self)
    @player = Player.new(self)
    @objects.push(@hud)
    @objects.push(@bg)
    @objects.push(@player)
    self.place_swarm # Setup our test enemies.
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

  # Used to stress-test.
  def place_swarm
    100.times do |i|
      self.objects.push(Enemy.new(self,450+i,140+i))
    end
    100.times do |i|
      self.objects.push(Enemy.new(self,450+i,240+i))
    end
  end

  def update
    super
  end

  def draw
    super
  end
end
