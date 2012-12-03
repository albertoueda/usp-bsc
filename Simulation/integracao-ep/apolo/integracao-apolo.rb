#!/bin/env ruby
# encoding: utf-8

require 'scanf'

require_relative '../../lib/physics'


class Circle < PhysicObject

    def validate_position
      if @shape.body.p.x > 1000 || @shape.body.p.x < -200 || 
        @shape.body.p.y > 800  || @shape.body.p.y < -200
        return false
      end
      return true
    end
end

class ApoloIntegrationWindow < PhysicWindow

  def setup
    super
    self.caption = "Physimulation - Integração com EP Apolo"
    @background_image = Gosu::Image["Space2.png"]

    @dt = 1.0 / 60.0
    @substeps = 1

    $draw_segments = false
    @circles = []
    create_objects

    $space.add_collision_func(:bixo, :alvo) do |bixo_shape, alvo_shape| 
      $success = true
    end    
  end

  def create_objects 
    Config::Circles.each do |circle|
      @circles << Circle.create(circle)
    end
  end

  def info
     "INFO
     #{@feedbackMessage}"
  end

  def update
    @substeps.times do
      super
    end

    # Nave - Lua
    distsq_nave_lua = @circles[0].body.p.distsq(@circles[1].body.p)
    dist_nave_lua = @circles[0].body.p.dist(@circles[1].body.p)
    dist_y_nave_lua = @circles[1].body.p.y - @circles[0].body.p.y
    dist_x_nave_lua = @circles[1].body.p.x - @circles[0].body.p.x

    impulse =  8.65 * 5.97 * 10**5 * 3.5/ distsq_nave_lua
    impulse_y = dist_y_nave_lua/dist_nave_lua * impulse
    impulse_x = dist_x_nave_lua/dist_nave_lua * impulse
    @circles[0].body.apply_impulse(vec2(impulse_x, impulse_y), vec2(0, 0))

    # Nave - Terra
    distsq_nave_terra = @circles[0].body.p.distsq(@circles[2].body.p)
    dist_nave_terra = @circles[0].body.p.dist(@circles[2].body.p)
    dist_y_nave_terra = @circles[2].body.p.y - @circles[0].body.p.y
    dist_x_nave_terra = @circles[2].body.p.x - @circles[0].body.p.x

    impulse =  8.65 * 7.35 * 10**6 / distsq_nave_terra
    impulse_y = dist_y_nave_terra/dist_nave_terra * impulse
    impulse_x = dist_x_nave_terra/dist_nave_terra * impulse
    @circles[0].body.apply_impulse(vec2(impulse_x, impulse_y), vec2(0, 0))

    # close if $success || ! @circles[0].validate_position
  end

  def draw
    super
    @background_image.draw(0, 0, 0) if not $draw_segments
  end
end

def generate_config_file
  file_content = "
  require 'chipmunk'
  require 'gosu'
  
  module Config
    " + config_objects + "
  end"

  File.open('config/config_gerado.rb', 'w') do |file|  
    file.puts file_content
  end 

  eval(File.open("config/config_gerado.rb").read)
end

def config_objects
  objects = ""
  
  objects += "
    Circles = [{
      :mass => 10000,
      :radius => 20,
      :factor_x => 0.5, 
      :factor_y => 0.5,
      :center_x => 1.0,
      :center_y => 1.0,
      :x => #{@pX},
      :y => #{@pY},
      :v => vec2(#{@vX}, #{@vY}),
      :moment_inertia => 100000,
      :collision_type => :nave,
      :image_name => 'rocket.png',
    }, {
      :radius => 10,
      :factor_x => 1, 
      :factor_y => 1,
      :x => 600,
      :y => 300,
      :collision_type => :lua,
      :image_name => 'cannonball2.png',
      :static => true
    }, {
      :radius => 50,
      :factor_x => 1/5.0, 
      :factor_y => 1/5.0,
      :x => 150,
      :y => 300,
      :collision_type => :terra,
      :image_name => 'globe.png',
      :static => true
    }]"  

  objects
end

def read_file_input
  filename = ARGV[0] ? ARGV[0] : "entrada.txt"

  file = File.new(filename, "r")
  file.gets
  @pX, @pY, @vX, @vY = file.gets.scanf("%F %F %F %F") 
  $total_time, @delta_t = file.gets.scanf("%F %F") 

end

def show_simulation
  window = ApoloIntegrationWindow.new 800, 600
  window.show
end

# Rotina principal

read_file_input
generate_config_file
show_simulation