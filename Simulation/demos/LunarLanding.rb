#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative 'lib/physics'

class LunarRocket < PhysicObject
  attr_accessor :engaged

  # @shape.body.p = CP::Vec2.new(100.0, 300.0)
  
  def setup
    super
    self.input = {:holding_right => :move_right, :holding_left => :move_left, 
      :holding_up => :move_up, :holding_down => :move_down}

    @image = Gosu::Image["spaceship.png"]
    @engaged = true
  end
 
  def move_right
    apply_impulse(50, 0.0)
  end
  
  def move_left
    apply_impulse(-50, 0.0)
  end  
  
  def move_up
    apply_impulse(0.0, -50.0)
  end

  def move_down
    apply_impulse(0.0, 50.0)
  end

  def restart
    @body.p = vec2(50 + rand(400), 100 + rand(100))  
    @body.v = CP::Vec2::ZERO
    @body.a = 0 
    @body.w = 0 
    @engaged = true

    # TODO melhor fazer algo como
    # $space.remove_body(@rocket.body)
    # @rocket = LunarRocket.create(ObjectConfig::LunarRocket)   
  end
end

class Demo3Window < PhysicWindow

  def setup
    self.caption = "TCC Demo 3 - Rocket Landing"
    self.input = {esc: :exit}

    @background_image = Gosu::Image["demo-tcc-3.png"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]
    @info_area = Chingu::Text.create("", :x => 300, :color => Gosu::Color::BLUE)    

    $space.damping = 1.0    
    $space.gravity = CP::Vec2.new(0.0, 5.0)

    @rocket = LunarRocket.create(ObjectConfig::LunarRocket)

    @segment_shapes= []
    @draw_segments = true

    soil_segments = [[vec2(0, 600), vec2(340, 600)],
                     [vec2(340, 600), vec2(380, 570)],
                     [vec2(380, 570), vec2(800, 570)]] 

    soil_segments.each do |limit|
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => limit, :thickness => 1})
      segment.collision_type = :soil
      segment.e = 1.0
      segment.u = 1.0
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    screen_limits = [[vec2(0, -1000), vec2(0, 600)], 
                     [vec2(800, 570), vec2(800, -1000)]] 

    screen_limits.each do |limit|
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => limit, :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.0
      segment.u = 0.0
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    $space.add_collision_func(:rocket, :soil) do |rocket_shape, soil_shape|
      if (@rocket.velocity.x.abs > 10 || @rocket.velocity.x.abs > 10) # deixar para rocket decidir
        @fire_sound.play        
        @rocket.engaged = false
        @feedbackMessage = "Exploded."
      else #if (@rocket.velocity.x.abs < 0.0001 and @rocket.velocity.y.abs < 0.0001 )
        @point_sound.play
        @rocket.engaged = false # TODO deixar ele parado
        @feedbackMessage = "Success!"
        # @feedbackMessage = "Success! - Press the [Spacebar] to restart."
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
     #{@feedbackMessage}"
  end

  def update
    super
    @info_area.text = info
    @feedbackMessage = ""  

    if (@rocket.engaged)
      @feedbackMessage = "Engaged."
    else
      @rocket.restart
    end
  end
  def draw
    super
    @background_image.draw(0, 0, 0)

      if @draw_segments 
        @segment_shapes.each { |segment| 
          vectorA = segment.a
          vectorB = segment.b
          $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
        } 
      end     
  end
end

Demo3Window.new(800, 600).show