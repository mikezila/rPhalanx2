# This whole class is just proof/experimentation of concept.
# Also the update method is hilarious.

class Explosion < GameObject
  def initialize(game,x,y)
    super game
    @tags.push("explosion")
    @tags.push("effects")
    @gfx = Gosu::Image.load_tiles(game.window,'./gfx/boom.png',129,196,false)
    @x = x
    @y = y
    @frame = 9
  end

  # This is hilarously lame to work around a broken gif with out of order frame I pulled from somebody myspace page, just for testing honest!
  def update
    if @frame == @gfx.length - 1
      @frame = 0
    elsif @frame == 7
      @frame += 1
      @deleted = true
    else
      @frame += 1
    end
  end

  # Also using scaling because if you're going to make a shit sandwich might as well put extra shit on it.
  def draw
    game.window.scale(0.3,0.3,@x,@y){
      @gfx[@frame].draw_rot(@x,@y,Zorder::Effects,0)
    }
  end
end
