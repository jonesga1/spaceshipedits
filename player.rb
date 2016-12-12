require 'gosu'
require './player.rb'
require './star.rb'
require './enemy.rb'

class Player
  def initialize
    @image = Gosu::Image.new("media/starfighter.bmp")
    @beep = Gosu::Sample.new("media/beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @health = 1000
    @lives = 3
    @number = 0
  end

  def x
    @x
  end

  def y
    @y
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def score
    @score
  end

  def health
    @health
  end

  def lives
    @lives
  end

  def hitPlayer(enemy)
    if Gosu::distance(@x, @y, enemy.x, enemy.y) < 40 then
      if health < 0
        @health = 1000
        @lives = @lives - 1
      else
        @health -= 10
      end
    end
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end
end
