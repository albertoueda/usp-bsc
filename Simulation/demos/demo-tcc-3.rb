#!/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'chingu'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
MAX_ANGLE = 100.0
MIN_ANGLE = 5.0
SUBSTEPS = 6

class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end

  def angle_to_vec2
    CP::Vec2.new(Math::cos(self * Math::PI / 180.0), - Math::sin(self * Math::PI / 180.0))
  end
end

module ZOrder
  Background, Land, Rocket, UI = *0..3
end

class Rocket
  attr_reader :shape
  attr_accessor :engaged

  def initialize(window, shape)
    @image = Gosu::Image["spaceship.png"]
    @shape = shape
    @shape.body.p = CP::Vec2.new(100.0, 300.0)
    @engaged = false
  end
 
  def move_right
    @shape.body.apply_force(CP::Vec2.new(1.0, 0.0) * 10/SUBSTEPS, CP::Vec2.new(0.0, 0.0))
  end
  
  def move_left
    @shape.body.apply_force(CP::Vec2.new(-1.0, 0.0) * 10/SUBSTEPS, CP::Vec2.new(0.0, 0.0))
  end  
  
  def move_up
    @shape.body.apply_force(CP::Vec2.new(0.0, -1.0) * 30/SUBSTEPS, CP::Vec2.new(0.0, 0.0))
  end

  def move_down
    @shape.body.apply_force(CP::Vec2.new(0.0, 1.0) * 15/SUBSTEPS, CP::Vec2.new(0.0, 0.0))
  end
  
  def draw
    @image.draw_rot(@shape.body.p.x, @shape.body.p.y, ZOrder::Rocket, @shape.body.a.radians_to_gosu)
  end 

  def decrease_y_speed
  	if @shape.body.v.y < 0
  	    @shape.body.apply_force(CP::Vec2.new(0.0, 1.0) * 0.5/SUBSTEPS, CP::Vec2.new(0.0, 0.0))
  	end
  end
end

# TODO: Unificar windows
class Demo3Window < Chingu::Window

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false, 16)
    self.caption = "TCC Demo 3 - Rocket Landing"

    @background_image = Gosu::Image["demo-tcc-3.jpg"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]
    @score = 0    
    @steps = 0

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @dt = 1.0/60.0    
    
    @space = CP::Space.new
    @space.damping = 0.2    
    @space.gravity = CP::Vec2.new(0.0, 5.0)

    rocket_body = CP::Body.new(100, 15000)
    shape_array = [CP::Vec2.new(-50.0, -14.0), CP::Vec2.new(-50.0, 14.0), CP::Vec2.new(50.0, 14.0), CP::Vec2.new(50.0, -14.0)]
    rocket_shape = CP::Shape::Poly.new(rocket_body, shape_array, CP::Vec2.new(0,0))
    rocket_shape.collision_type = :rocket
    @rocket = Rocket.new(self, rocket_shape)
    @space.add_shape(rocket_shape)
    @space.add_body(rocket_body)    
  end

  def update
   SUBSTEPS.times do
	  @rocket.decrease_y_speed
          
      @feedbackMessage = ""  

      if (@rocket.engaged)
        @feedbackMessage = "Engaged."      
      end

      if button_down? Gosu::KbLeft
        @rocket.move_left
      end

      if button_down? Gosu::KbRight
        @rocket.move_right
      end

      if button_down? Gosu::KbUp
        @rocket.move_up
      end

      if button_down? Gosu::KbDown
        @rocket.move_down
      end
      
      @space.step(@dt)
    end        
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @rocket.draw
    
    @font.draw("Score: #{@score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff000000)    
    @font.draw("Speed (x, y): #{@rocket.shape.body.v}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xff000000)        	
    @font.draw("#{@feedbackMessage}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xff000000)    
    @font.draw("Steps: #{@steps}", 500, 10, ZOrder::UI, 1.0, 1.0, 0xff000000)
    @font.draw("Position (x, y): #{@rocket.shape.body.p}", 500, 30, ZOrder::UI, 1.0, 1.0, 0xff000000)        
  end

  def button_down(id)
    if id == Gosu::KbEscape then
      close
    end
  end

end


window = Demo3Window.new
window.show
