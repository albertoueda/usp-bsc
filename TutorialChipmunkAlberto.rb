require 'rubygems'
require 'gosu'
require 'chipmunk'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480
SUBSTEPS = 6

class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end
end

module ZOrder
  Background, Stars, Player, UI = *0..3
end

class Player
  attr_reader :shape

  def initialize(window, shape)
    @image = Gosu::Image.new(window, "media/Starfighter.bmp", false)
    @shape= shape
    @shape.body.p = CP::Vec2.new(0.0, 0.0) # position
    @shape.body.v = CP::Vec2.new(0.0, 0.0) # velocity
  end

  def warp(vector)
    @shape.body.p = vector
  end
  
  def turn_left
    @shape.body.t -= 400.0/SUBSTEPS
  end
  
  def turn_right
    @shape.body.t += 400.0/SUBSTEPS
  end
  
  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0/SUBSTEPS)), CP::Vec2.new(0.0, 0.0))
  end

  def boost
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0)), CP::Vec2.new(0.0, 0.0))
  end

  def reverse
    @shape.body.apply_force(-(@shape.body.a.radians_to_vec2 * (2000.0/SUBSTEPS)), CP::Vec2.new(0.0, 0.0))
  end
  
  def draw
    @image.draw_rot(@shape.body.p.x, @shape.body.p.y, ZOrder::Player, @shape.body.a.radians_to_gosu)
  end 

  def validate_position
    begin_x = @image.width / 2.0
    end_x = SCREEN_WIDTH - @image.width / 2.0
    begin_y = @image.height / 2.0
    end_y= SCREEN_HEIGHT - @image.height / 2.0

    x = @shape.body.p.x
    y = @shape.body.p.y

    if x >= end_x
        x = end_x
    elsif x <= begin_x
        x = begin_x
    end

    if y >= end_y
        y = end_y
    elsif y <= begin_y
        y = begin_y
    end

    l_position = CP::Vec2.new(x, y)
    @shape.body.p = l_position
  end
end

class Star
  attr_reader :shape
  
  def initialize(animation, shape)
    @animation = animation
    @color = Gosu::Color.new(0xffffffff)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40

    @shape = shape
    @shape.body.p = CP::Vec2.new(rand * SCREEN_WIDTH, rand * SCREEN_HEIGHT)
    @shape.body.v = CP::Vec2.new(0.0, 0.0)
    @shape.body.a = (3*Math::PI/2.0)
  end

  def draw  
    img = @animation[Gosu::milliseconds / 100 % @animation.size]
    img.draw(@shape.body.p.x - img.width / 2.0, @shape.body.p.y - img.height / 2.0, ZOrder::Stars, 1, 1, @color, :add)
  end

  def validate_position    
    @shape.body.p = CP::Vec2.new(@shape.body.p.x % SCREEN_WIDTH, @shape.body.p.y % SCREEN_HEIGHT)
  end
end

class GameWindow < Gosu::Window

  def initialize
    super(640, 480, false)    
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false, 16)
    self.caption = "Gosu & Chipmunk Integration Demo - Alberto"

    @background_image = Gosu::Image.new(self, "media/Space2.jpg", true)
    @beep = Gosu::Sample.new(self, "media/Beep.wav")   
    @score = 0    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @dt = 1.0/60.0    
    
    @space = CP::Space.new
    @space.damping = 0.7    
    @space.gravity = CP::Vec2.new(0.0, 1.5)

    body = CP::Body.new(10.0, 150.0)
    shape_array = [CP::Vec2.new(-25.0, -25.0), CP::Vec2.new(-25.0, 25.0), CP::Vec2.new(25.0, 1.0), CP::Vec2.new(25.0, -1.0)]
    shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
    shape.collision_type = :ship
    
    @space.add_body(body)
    @space.add_shape(shape)

    @player = Player.new(self, shape)
    @player.warp(CP::Vec2.new(120, 240))

    @star_anim = Gosu::Image::load_tiles(self, "media/Star.png", 25, 25, false)
    @stars = Array.new    

    @remove_shapes = []     
    @space.add_collision_func(:ship, :star) do |ship_shape, star_shape|

      if ship_shape.body.v.x.to_i.abs > 80 || ship_shape.body.v.y.to_i.abs > 80 then       
        @score += 10      
        @beep.play
        @remove_shapes << star_shape
      else            
        # Bug bizarro : é necessário algum comando aqui para o bloco funcionar corretamente (não vale printf)
        @remove_shapes
      end
    end

    # @space.add_collision_func(:star, :star, &nil)
  end

  def update
   SUBSTEPS.times do
      @remove_shapes.each do |shape|
        @stars.delete_if { |star| star.shape == shape }
        @space.remove_body(shape.body)
        @space.remove_shape(shape)
      end
      @remove_shapes.clear   

      # @player.shape.body.reset_forces
      @player.validate_position

      @stars.each do |star|
        star.validate_position
      end

      if button_down? Gosu::KbLeft
        @player.turn_left
      end
      if button_down? Gosu::KbRight
        @player.turn_right
      end
      
      if button_down? Gosu::KbUp
        if ( (button_down? Gosu::KbRightShift) || (button_down? Gosu::KbLeftShift) )
          @player.boost
        else
          @player.accelerate
        end
      elsif button_down? Gosu::KbDown
        @player.reverse
      end
      
      @space.step(@dt)
    end
    
    if rand(100) < 5 and @stars.size < 50 then
      body = CP::Body.new(0.0001, 0.0001)
      shape = CP::Shape::Circle.new(body, 25/2, CP::Vec2.new(0.0, 0.0))
      shape.collision_type = :star
      
      @space.add_body(body)
      @space.add_shape(shape)
      
      @stars.push(Star.new(@star_anim, shape))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Total of Stars: #{@stars.size}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Ship Vx, Vy: #{@player.shape.body.v.x}, #{@player.shape.body.v.y}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xffffff00)    
    @font.draw("Ship.T: #{@player.shape.body.t}", 10, 70, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    if id == Gosu::KbEscape then
      close
    end
  end
end

window = GameWindow.new
window.show