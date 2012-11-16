#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config_gerado'
require_relative '../lib/physics'

class Circle < PhysicObject
end

class Triangle < PhysicObject
end

class Rectangle < PhysicObject
end

class Segment < PhysicObject
end

class TesteWindow < PhysicWindow

  def setup
    super
    self.caption = "Physics Simulation - Teste"

    @background_image = Gosu::Image["Space2.png"]
    @static_shapes = []
    @substeps = 2

    create_objects

    screen_points = [vec2(2, 2), vec2(2, 598), 
                     vec2(798, 598), vec2(798, 2)] 

    @space_simulation = TestObjectConfig::Space.new
    $space.damping = @space_simulation.damping    
    $space.gravity = @space_simulation.gravity

    if (@space_simulation.limited_space)
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

  end

  def create_objects 
    TestObjectConfig::Circles.each do |circle|
      Circle.create(circle)
    end
    TestObjectConfig::Triangles.each do |triangle|
      Triangle.create(triangle)
    end
    TestObjectConfig::Rectangles.each do |rectangle|
      Rectangle.create(rectangle)
    end
    TestObjectConfig::Segments.each do |segment|
      Segment.create(segment)
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