#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative '../lib/physics'

class Rocket < PhysicObject

  def setup
    super
    default_input = self.input
    self.input = {:holding_right => :accelerate_to_moon, :holding_left => :accelerate_to_earth}
    self.input.merge! default_input

    @earth_acceleration = 0
    @moon_acceleration = 0

    self.body.velocity_func { |body, gravity, damping, dt|
      # G é considerado 1 e o vetor é sempre paralelo ao eixo x 
      @earth_acceleration = -5.973 * 10**5 / self.position.distsq(vec2(0, self.position.y))
      @moon_acceleration =  7.349 * 10**4 / self.position.distsq(vec2(1024, self.position.y))

      self.body.update_velocity(vec2(@earth_acceleration + @moon_acceleration, 0), damping, dt)
    }

    @image = Gosu::Image["rocket.png"]

    @rocket_info = Chingu::Text.create("", :x => 300)
  end

  def accelerate_to_moon
    apply_impulse(40000, 0)
  end

  def accelerate_to_earth
    apply_impulse(-40000, 0)
  end

  def info
    acceleration = @earth_acceleration + @moon_acceleration
    "INFO
    Aceleração Terra: #{(@earth_acceleration * 100).round / 100.0}
    Aceleração Lua: #{(@moon_acceleration * 100).round / 100.0}
    Posição: #{position}
    Aceleração Resultante: #{acceleration}
    [D] : Show lines"
    # Velocidade: #{velocity}
  end

  def update
    @rocket_info.text = info
  end
end

class RocketSimulation < PhysicWindow
  def setup
    super
    self.caption = "Physics Simulation #3 - Rocket Simulation"

    default_input = self.input
    self.input = {esc: :exit}
    self.input.merge! default_input

    @rocket = Rocket.create(ObjectConfig::Rocket)

    @earth_info = Chingu::Text.create("Terra", x: 55, y: 0)
    @moon_info = Chingu::Text.create("Lua", x: 1000, y: 0)

    @earth_segment = CP::Shape::Segment.new(CP::StaticBody.new, vec2(50, 0), vec2(50, 600), 1)
    @moon_segment = CP::Shape::Segment.new(CP::StaticBody.new, vec2(975, 0), vec2(975, 600), 1)
    @earth_segment.add_to_space($space)
    @moon_segment.add_to_space($space)
  end

  def draw
    super
    $window.draw_line(@earth_segment.a.x, @earth_segment.a.y, Gosu::Color::WHITE, @earth_segment.b.x, @earth_segment.b.y, Gosu::Color::WHITE)
    $window.draw_line(@moon_segment.a.x, @moon_segment.a.y, Gosu::Color::WHITE, @moon_segment.b.x, @moon_segment.b.y, Gosu::Color::WHITE)
  end
end

RocketSimulation.new(1024, 600).show
