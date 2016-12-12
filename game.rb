require 'gosu'
require './player.rb'
require './star.rb'
require './enemy.rb'

class GameWindow < Gosu::Window

  def initialize
    super 640, 480
    self.caption = "Hello, World"

    @background_image = Gosu::Image.new("media/space.png", :tileable => true)

    @player = Player.new
    @player.warp(320, 240)

    @enemy = Enemy.new
    @enemy.warp(320, 240)

    @star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
    @stars = Array.new

    @font = Gosu::Font.new(20)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)

    @player.hitPlayer(@enemy)

    @enemy.follow(@player.x, @player.y)

    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    if @player.lives > -1
      @enemy.draw
      @player.draw
      @stars.each { |star| star.draw }
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Health: #{@player.health}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Lives: #{@player.lives}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    else
      @font.draw("You have died! Your final score was #{@player.score}!", 100, 235, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    end
  end



  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

module ZOrder
  Background, Stars, Player, UI = *0..3
end

window = GameWindow.new
window.show
