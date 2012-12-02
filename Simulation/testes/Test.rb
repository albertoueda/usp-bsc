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
    @dt = 1.0 / 40.0
    @substeps = 2

    create_objects

    screen_points = [vec2(20, 20), vec2(20, 580), 
                     vec2(780, 580), vec2(780, 20)] 

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
     Total Círculos:      #{'%02d' % TestObjectConfig::Circles.size}
     Total Triângulos:   #{'%02d' % TestObjectConfig::Triangles.size}
     Total Retângulos:  #{'%02d' % TestObjectConfig::Rectangles.size}
     Total Segmentos:  #{'%02d' % TestObjectConfig::Segments.size}
     #{@feedbackMessage}"
  end

  def update
    @substeps.times do
      super
      @feedbackMessage = ""
    end

    if (@space_simulation.object_gravity)
      $all_objects.each do |object1|
        $all_objects.each do |object2|

          # TODO static check
          if (object1 == object2 || object1.body.mass == CP::INFINITY || object2.body.mass == CP::INFINITY)
            next
          end

          distsq = object1.body.p.distsq(object2.body.p)
          dist = object1.body.p.dist(object2.body.p)
          dist_y = object2.body.p.y - object1.body.p.y
          dist_x = object2.body.p.x - object1.body.p.x

          # G constant
          impulse =  10000 * object2.body.m / distsq
          impulse_y = dist_y/dist * impulse
          impulse_x = dist_x/dist * impulse

          object1.body.apply_impulse(vec2(impulse_x, impulse_y), vec2(0, 0))

        end
      end
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

  def custom_setup
    # Implementação opcional 
  end
end

Dir['ext/*.rb'].each do |source|
  p eval(File.open(source).read)
end

window = TesteWindow.new 800, 600
window.custom_setup
window.show
