#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative 'lib/physics'

class Rock < PhysicObject
  attr_accessor :engaged
  
  def setup
    super
    # self.input = {:holding_right => :move_right, :holding_left => :move_left, 
      # :holding_up => :move_up, :holding_down => :move_down}

    @image = Gosu::Image["cannonball2.png"]
    @engaged = true
  end

  def restart
    @body.p = vec2(50 + rand(200), 500)  
    @body.v = CP::Vec2::ZERO
    @body.a = 0 
    @body.w = 0 
    @engaged = true
  end

  def shoot
    apply_impulse(20000, -15000 - rand(10000))
  end
end

class Stone < PhysicObject

  def setup
    super
    @image = Gosu::Image["stone.png"]
  end
end

class WoodStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["woodstone.png"]
  end
end

class GemStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["gem.png"]
  end
end

class GemBallStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["gem-ball.png"]
  end
end

class RocksSimulation < PhysicWindow

  def setup
    self.caption = "TCC Demo 2 - Rocks"
    self.input = {esc: :exit, space: :shoot, r: :restart, d: :toggle_lines}

    # @background_image = Gosu::Image["fundo-demo-tcc-2.png"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]
    @info_area = Chingu::Text.create("", :x => 300, :color => Gosu::Color::BLUE)    

    $space.damping = 0.9    
    $space.gravity = CP::Vec2.new(0.0, 150.0)

    @rock = Rock.create(ObjectConfig::Rock)

    @segment_shapes= []
    @draw_segments = false

    screen_points = [vec2(0, -1000), vec2(0, 600), 
                     vec2(800, 600), vec2(800, -1000)] 

    for i in 0..screen_points.size-2
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => [screen_points[i], screen_points[i+1]],
        :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.5
      segment.u = 0.5
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    restart

    # $space.add_collision_func(:rock, :stone) do |rock_shape, stone_stone|
    #   @point_sound.play
    # end 

  end

  def info
    "INFO
     Position (x, y): #{@rock.position}
     Speed (x, y):   #{@rock.body.v}
     #{@feedbackMessage}"
  end

  def update
    super
    @info_area.text = info
    @feedbackMessage = ""  

    if (@rock.engaged)
      @feedbackMessage = "Engaged."
    else
      restart
    end
  end

  def draw
    super
    # @background_image.draw(0, 0, 0)

      if @draw_segments 
        @segment_shapes.each { |segment| 
          vectorA = segment.a
          vectorB = segment.b
          $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
        } 
      end     
  end

  def shoot
    @rock.shoot
  end
  
  def restart
    @rock.restart

    for i in 0..4
      stone = Stone.create(ObjectConfig::Stone)
      stone.body.p = vec2(300 + rand(200), 100 + rand(300)) # stone.p

      woodstone = WoodStone.create(ObjectConfig::WoodStone)
      woodstone.body.p = vec2(300 + rand(200), 100 + rand(300))
      
      gemstone = GemStone.create(ObjectConfig::Gem)
      gemstone.body.p = vec2(300 + rand(200), 100 + rand(300))
    
      gemballstone = GemBallStone.create(ObjectConfig::GemBall)
      gemballstone.body.p = vec2(300 + rand(200), 100 + rand(300))
    end
  end

  def toggle_lines
    @draw_segments = !@draw_segments  
  end
end

RocksSimulation.new(800, 600).show