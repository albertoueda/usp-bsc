#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config_gerado'
require_relative '../lib/physics'

class Rock < PhysicObject
end

class TesteWindow < PhysicWindow

  def setup
    super
    self.caption = "Physics Simulation - Teste"

    $space.damping = 0.9    
    $space.gravity = CP::Vec2.new(0.0, 5.0)

    @background_image = Gosu::Image["Space2.png"]
    @rock = Rock.create(TestObjectConfig::Rock)
    @static_shapes = []

    screen_points = [vec2(2, 2), vec2(2, 598), 
                     vec2(798, 598), vec2(798, 2)] 

    for i in 0..screen_points.size-1
      segment = CP::Shape.factory(CP::StaticBody.new, 
        {:vectors => [screen_points[i], screen_points[(i+1)%screen_points.size]],
        :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.9
      segment.u = 0.5
      @static_shapes << segment
      segment.add_to_space($space)
    end

  end

  def info
    "INFO
     #{@feedbackMessage}"
  end

  def update
    @substeps.times do
      super
      @feedbackMessage = ""
    end
  end

  def draw
    # TODO Zorder
    super

    if $draw_segments 
      @static_shapes.each { |segment| 
        vectorA = segment.a
        vectorB = segment.b
        $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
      } 
    else
      @background_image.draw(0, 0, 0)
    end     
  end
end

TesteWindow.new(800, 600).show