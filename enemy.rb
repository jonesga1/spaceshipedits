require 'gosu'
require './player.rb'
require './star.rb'

class Enemy
  def initialize
    @image = Gosu::Image.new("media/enemy.bmp")
    @angle = 0.0
    @number = 0
    @damage = 10
    @ex = 0
    @ey = 0
    @speed = 1
  end

  def draw
    @image.draw(@ex, @ey, @angle)
  end

  def x
    @ex
  end

  def y
    @ey
  end

  def warp(x, y)
    @ex, @ey = x, y
  end

  def follow(x, y)
    if x > @ex
      @ex += @speed
    elsif @ex > x
      @ex -= @speed
    end
    if y > @ey
      @ey += @speed
    elsif @ey > y
      @ey -= @speed
    end
    @number += 1
    if @number == 1000
      @speed += 1
      @number = 0
    end
  end

end
