# This Hud class isn't updated from the outside, instead it evaluates the objects in the game and displays information itself.  Makes good use of tags to find and get info from gameobjects.

class Hud < GameObject

  def initialize(game)
    super game
    @font = Gosu::Font.new(game.window,"./gfx/AGENCYR.TTF",26)
    @tags.push("hud")
  end

  def update
    update_debug if DEBUG
  end

  def update_debug
    @enemy_shots = 0
    @enemies = 0

    game.objects.each do |object|
      if object.tags.include? "enemy_shot"
        @enemy_shots += 1
      end

      if object.tags.include? "enemy_ship"
        @enemies += 1
      end

      if object.tags.include? "player_ship"
        @health = object.health
        @boost  = object.boost
      end
    end
  end

  def draw
    # Since this is all debugging information, only display it if DEBUG is on.
    @font.draw("Boost factor: #{@boost} Live player shots: #{game.player.shots.length} Live enemies: #{@enemies}", 10, 10, Zorder::HUD) if DEBUG
    @font.draw("Health: #{@health} Live enemy shots: #{@enemy_shots}", 10, 28, Zorder::HUD) if DEBUG
    @font.draw("DEBUG MODE", 20, game.window.height - 30, Zorder::HUD) if DEBUG
    @font.draw("fps: #{Gosu::fps}", game.window.width - 80, game.window.height - 30, Zorder::HUD)
  end
end