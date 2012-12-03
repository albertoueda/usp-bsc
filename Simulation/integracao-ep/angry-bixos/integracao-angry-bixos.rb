#!/bin/env ruby
# encoding: utf-8

require 'scanf'

require_relative '../../lib/physics'

class Circle < PhysicObject

    def validate_position
      if (@shape.body.p.x > $nCol + 50 || @shape.body.p.x < -50 || @shape.body.p.y > $nLin + 50)
        return false
      end
      return true
    end
end

class Rectangle < PhysicObject
end 

class AngryBixosIntegrationWindow < PhysicWindow

  def setup
    super
    self.caption = "Physimulation - Integração com EP Angry Bixos"
    @background_image = Gosu::Image["fundo-demo-1.png"]

    @dt = 1.0 / 60.0
    @substeps = 1

    @space_simulation = Config::Space.new
    $space.gravity = @space_simulation.gravity
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
    Config::Rectangles.each do |rectangle|
      Rectangle.create(rectangle)
    end
  end

  def info
     "INFO
     Tentativas restantes: #{'%02d' % ($nBix - $jogada)}"
  end

  def update
    @substeps.times do
      super
    end

    close if $success || ! @circles[0].validate_position
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

    class Space
      attr_accessor :gravity, :damping

      def initialize
        @gravity = vec2(0, #{-@g * 10.0})
      end
    end

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
      :mass => 100,
      :radius => 15,
      :factor_x => 1.5, 
      :factor_y => 1.5,
      :x => 50,
      :y => #{@yE},
      :v => vec2(#{@vX}, #{@vY}),
      :moment_inertia => 100000,
      :elasticity => 0.8,
      :friction => 0.8,
      :collision_type => :bixo,
      :image_name => 'cannonball2.png',
    }] 
    "  

  objects += " 
    Rectangles = [{
      :x => 750,
      :y => #{@yA},
      :vectors => [vec2(-30, -#{@hA/2}), vec2(-30, #{@hA/2}), 
                   vec2(30, #{@hA/2}), vec2(30, -#{@hA/2})],
      :elasticity => 0.8,
      :friction => 0.8,
      :collision_type => :alvo,
      :image_name => 'target.png',
      :factor_x => 1.5,
      :factor_y => #{@hA/60.0},
      :static => true
    }] "

  objects
end

def config_segments
  segments = ""
  
  segments += "{
      :x => 50,
      :y => #{@yE + 20},
      :thickness => 1,
      :vectors => [vec2(-1, 0), vec2(1, 0)],
      :static => true
  }"

  segments
end

def read_file_input
  filename = ARGV[0] ? ARGV[0] : "entrada.txt"

  file = File.new(filename, "r")
  @yE, @vMax = file.gets.scanf("%d %d")
  @yA , @hA = file.gets.scanf("%d %d") 
  @dist,* = file.gets.scanf("%d") 
  $nBix,* = file.gets.scanf("%d") 
  $nLin, $nCol = file.gets.scanf("%d %d") 
  @nUni,* = file.gets.scanf("%d") 
  @g,* = file.gets.scanf("%d") 
end

def read_user_input
  @des, @ori = scanf("%F, %F")

  @vX = @des * @vMax * Math::cos(@ori * Math::PI/2.0)
  @vY = @des * @vMax * Math::sin(@ori * Math::PI/2.0) * (-1.0)
end

def show_simulation
  window = AngryBixosIntegrationWindow.new $nCol, $nLin
  window.show
end

# Rotina principal

read_file_input
puts "\nPara fazer um lancamento, digite um deslocamento (no intervalo [0,1]) e uma orientacao (no intervalo [-1, 1]) \n\n"

for $jogada in 1..$nBix
  print "====> Faca o lancamento #{$jogada} / #{$nBix}: "
  read_user_input
  generate_config_file

  show_simulation
  break if $success

  puts "Voce nao acertou o alvo nessa jogada.\n\n"
end

puts "Parabens! Voce acertou o alvo nessa jogada.\n\nO jogo terminou.\n" if $success 
