# This Hud class isn't updated from the outside, instead it evaluates the objects in the game and displays information itself.  Makes good use of tags to find and get info from gameobjects.

class Hud < GameObject

  def initialize(game)
    super game
    @font = Gosu::Font.new(self.game.window,"./gfx/AGENCYR.ttf",26)
    @tags.push("hud")
  end

  def update
    self.update_debug if DEBUG
  end

  def update_debug
    @player_shots = 0
    @enemy_shots = 0
    @enemies = 0

    self.game.objects.each do |object|
      if object.tags.include? "enemy_shot"
        @enemy_shots += 1
      end

      if object.tags.include? "enemy_ship"
        @enemies += 1
      end

      if object.tags.include? "player_shot"
        @player_shots += 1
      end

      if object.tags.include? "player_ship"
        @health = object.health
      end

      if object.tags.include? "player_ship"
        @boost = object.boost
      end
    end
  end

  def draw
    # Since this is all debugging information, only display it if DEBUG is on.
    @font.draw("Boost factor: #{@boost} Live player shots: #{@player_shots} Live enemies: #{@enemies}", 10, 10, Zorder::HUD) if DEBUG
    @font.draw("Health: #{@health} Live enemy shots: #{@enemy_shots}", 10, 28, Zorder::HUD) if DEBUG
    @font.draw("DEBUG MODE", 20, self.game.window.height - 30, Zorder::HUD) if DEBUG
    @font.draw("fps: #{Gosu::fps}", self.game.window.width - 80, self.game.window.height - 30, Zorder::HUD)
  end
end
