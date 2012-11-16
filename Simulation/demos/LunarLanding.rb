#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative '../lib/physics'

class LunarRocket < PhysicObject
  attr_accessor :engaged
  
  def setup
    super
    default_input = self.input 
    self.input = { holding_right: :move_right, holding_left: :move_left, 
      holding_up: :move_up, holding_down: :move_down }
    self.input.merge! default_input

    @engaged = true
  end
 
  def move_right
    apply_impulse(100, 0.0)
  end
  
  def move_left
    apply_impulse(-100, 0.0)
  end  
  
  def move_up
    apply_impulse(0.0, -100.0)
  end

  def move_down
    apply_impulse(0.0, 100.0)
  end

  def restart
    @body.p = vec2(50 + rand(200), 100 + rand(100))  
    @body.v = CP::Vec2::ZERO
    @body.a = 0 
    @body.w = 0 
    @engaged = true
  end
end

class Demo3Window < PhysicWindow

  def setup
    super
    self.caption = "Physics Simulation #3 - Rocket Landing"
    
    default_input = self.input 
    self.input = { space: :restart }
    self.input.merge! default_input

    @background_image = Gosu::Image["fundo-demo-tcc-3.png"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]

    @info_area = Chingu::Text.create("", :x => 300, :color => Gosu::Color::RED)    
    @substeps = 1
    @dt = 1/40.0

    $space.damping = 1.0    
    $space.gravity = CP::Vec2.new(0.0, 5.0)

    @rocket = LunarRocket.create(ObjectConfig::LunarRocket)

    @segment_shapes= []

    soil_segments = [[vec2(1, 599), vec2(375, 599)],
                     [vec2(375, 599), vec2(375, 570)],
                     [vec2(375, 570), vec2(800, 570)]] 

    soil_segments.each do |limit|
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => limit, :thickness => 1})
      segment.collision_type = :soil
      segment.e = 0.0
      segment.u = 0.8
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    screen_limits = [[vec2(1, -1000), vec2(1, 599)], 
                     [vec2(799, 570), vec2(799, -1000)]] 

    screen_limits.each do |limit|
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => limit, :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.0
      segment.u = 0.5
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    $space.add_collision_func(:rocket, :soil) do |rocket_shape, soil_shape|
      if (@rocket.velocity.x.abs > 10 || @rocket.velocity.y.abs > 10) # deixar para rocket decidir
        @fire_sound.play        
        @rocket.engaged = false
        @feedbackMessage = "Exploded."
      else 
        @feedbackMessage = "Success! - Press the [Spacebar] to restart."
      end
    end  

    $space.add_collision_func(:rocket, :screen) do |rocket_shape, screen_shape|
        @fire_sound.play 
        @rocket.engaged = false
        @feedbackMessage = "Exploded."
    end  

  end

  def info
    "INFO
     Position (x, y): #{@rocket.position}
     Speed (x, y):   #{@rocket.body.v}
     #{@feedbackMessage}
     [D] : Show lines"
  end

  def update
    @substeps.times do 
      super
      @info_area.text = info

      if (@rocket.engaged)
        @feedbackMessage = "Engaged."
      else
        restart
      end
    end
  end

  def draw
    super

    if $draw_segments 
      @segment_shapes.each { |segment| 
        vectorA = segment.a
        vectorB = segment.b
        $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
      }
    else 
      @background_image.draw(0, 0, 0)
    end

  end

  def restart
    @rocket.restart
  end
end

Demo3Window.new(800, 600).show