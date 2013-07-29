class Hud < GameObject

  def initialize(game)
    super game
    @window = self.game.window
    @font = Gosu::Font.new(@window,"./gfx/AGENCYR.ttf",26)
    @tags.push("hud")
    @boost = 2
    @shots = 0
    @enemies = 0
    @health = 3
  end

  def update
    @shots = 0
    @enemies = 0

    self.game.objects.each do |object|
      if object.tags.include? "enemy_ship"
        @enemies += 1
      end
    end

    self.game.objects.each do |object|
      if object.tags.include? "player_shot"
        @shots += 1
      end
    end

    self.game.objects.each do |object|
      if object.tags.include? "player_ship"
        @health = object.health
      end
    end

    self.game.objects.each do |object|
      if object.tags.include? "player_ship"
        @boost = object.boost
      end
    end
  end

  def draw
    @font.draw("Boost factor: #{@boost} Live player shots: #{@shots} Live enemies: #{@enemies}", 10, 10, 2) if DEBUG
    @font.draw("Health: #{@health}", 10, 28, 2) if DEBUG
    @font.draw("DEBUG MODE", 20, @window.height - 30, 2) if DEBUG
    @font.draw("fps: #{Gosu::fps}", @window.width - 80, @window.height - 30, 2) if DEBUG
  end
end