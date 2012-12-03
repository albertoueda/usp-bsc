#!/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'chipmunk'
require 'chingu'
require 'gosu'
require 'forwardable'
require 'texplay'

# Variável global do CP::Space
$space = CP::Space.new

# Define se devem ser exibidas as linhas de contorno dos corpos
$draw_segments = false

$all_objects = []

# Adição de método para todos os números
class Numeric
  def radians_to_degrees
    self * 180 / Math::PI
  end
end

# Adição de método para faciliar a criação de Shapes do chipmunk.
#
# @author rafaelim, albertoueda
module CP
  module Shape
  
    Color = {CP::Shape::Circle => Gosu::Color::YELLOW, 
            CP::Shape::Segment => Gosu::Color::RED, 
            CP::Shape::Poly => Gosu::Color::GREEN, 
           }

    # @param [Hash] body corpo físico do chipmunk
    # @param params parâmetros utilizados para criar o shape do chipmunk.
    #	  O método sabe o tipo do shape que deve ser construído dependendo do parâmetro
    # @option params [Float] :radius o raio da circunferência
    # @option params [Float] :thickness espessura do segmento
    # @options params [Array] :vectors uma lista de vetores Vec2 do chipmunk. (Vértices)
    # @return Se existir o parâmetro :radius, devolve um Shape::Circle.
    #   Se existir o parâmetro :thickness, devolve um Shape::Segment utilizando os dois primeiros itens do :vectors como vértice
    #	  Se não acontecer nenhum dos casos anteriores, devolve um Shape.Polygon utilizando a lista de vetores.
    def self.factory(body, params = {})
      return Shape::Circle.new(body, params[:radius], Vec2::ZERO) if params.has_key? :radius
      return Shape::Segment.new(body, params[:vectors][0], params[:vectors][1], params[:thickness]) if params.has_key? :thickness
      return Shape::Poly.new(body, params[:vectors], Vec2::ZERO)
    end
  end
end

# trait do chingu para incorporar cálculos físicos no objeto chingu.
#
# @author rafaelim, albertoueda
#
# @!attribute force 
# 	@return [CP::Vec2] Força sendo aplicada no corpo
#	@todo verificar se funcionar o getter e o setter.
# @!attribute moment_inertia
# 	@return [Float] Momento de inércia do corpo
# @!attribute mass
# 	@return [Float] Massa do corpo
# @!attribute rotational_velocity
# 	@return [Float] Velocidade rotacional do corpo. É diferente de velocidade angular.
#                                                 
# @!attribute angle
# 	@return [Float] Ângulo rotacional do corpo.
module Chingu
  module Traits
    module Physics
      include Chingu::Helpers::RotationCenter
      extend Forwardable

      attr_accessor :factor_x, :factor_y, :center_x, :center_y, :zorder, :mode, :color, :visible, :body, :shape
      attr_reader :factor, :center, :height, :width, :image
      def_delegator :@body, :f, :force
      def_delegator :@body, :i, :moment_inertia
      def_delegator :@body, :m, :mass
      def_delegator :@body, :w, :rotational_velocity
      def_delegator :@body, :a, :angle
      def_delegator :@shape, :e, :elasticity
      def_delegator :@shape, :u, :friction


      # @param [Hash] options mapa com as opções de configuração do objeto físico.
      #   Além de aceitar as opções definidas em gosu e chingu, aceitam algumas propriedades físicas
      # @option options [Float] :mass massa do corpo. Obrigatório
      # @option options [Float] :moment_inertia momento de inércia do corpo. Obrigatório.
      # @option options [Float] :x posição inicial em relação ao eixo x do corpo. Obrigatório.
      # @option options [Float] :y posição inicial em relação ao eixo y do corpo. Obrigatório.
      # @option options [Float] :angle ângulo inicial do corpo. Padrão é 0.
      # @option options [Float] :rotaional_velocity velocidade rotacional do corpo. Padrão é 0.
      def setup_trait(options = {})
        @visible = true   unless options[:visible] == false
        self.color =  options[:color] || Gosu::Color::WHITE
        self.alpha =  options[:alpha]  if options[:alpha]
        self.mode =   options[:mode] || :default
        self.zorder = options[:zorder] || 100
        self.rotation_center = options[:rotation_center] || :center_center

        self.factor = options[:factor] || options[:scale] || $window.factor || 1.0
        self.factor_x = options[:factor_x].to_f if options[:factor_x]
        self.factor_y = options[:factor_y].to_f if options[:factor_y]

        if options[:static]
          @body = CP::StaticBody.new
        else
          @body = CP::Body.new(options[:mass], options[:moment_inertia])
          @body.v = options[:v] if options[:v]  
          @body.w = options[:rotational_velocity] || 0
          @body.add_to_space($space)
        end

        @body.p = vec2(options[:x], options[:y])
        @body.a = options[:angle] || 0

        @shape = CP::Shape.factory(@body, options)
        @shape.collision_type = options[:collision_type] if options[:collision_type]        
        @shape.e = options[:elasticity] if options[:elasticity]        
        @shape.u = options[:friction] if options[:friction]        
        @shape.add_to_space($space)

        @circle_image = TexPlay.create_blank_image($window, (options[:radius]*3).ceil, 
          (options[:radius]*3).ceil) if options[:radius]
        @vectors = options[:vectors] if options[:vectors]

        @image = Gosu::Image[options[:image_name]] if options[:image_name] 
        @shape_color = options[:shape_color] ? options[:shape_color] : CP::Shape::Color[@shape.class] 
        $all_objects << self

        super(options)
      end

      def factor=(factor)
        @factor = @factor_x = @factor_y = factor
      end

      # @return [CP::Vec2] Vetor posição do corpo
      def position
        @body.p
      end

      # @return [CP::Vec2] Vetor velocidade do corpo
      def velocity
        @body.v
      end

      def draw
        if $draw_segments
          shape_color = @shape_color # TODO

          case @shape
          when CP::Shape::Circle
            radius = @shape.radius.floor

            # Texplay painting
            @circle_image.paint {
                circle radius, radius, radius, :color => shape_color
            }

            @circle_image.draw(position.x - radius, position.y - radius, 0)

          when CP::Shape::Segment, CP::Shape::Poly

            for i in 0..@vectors.size 
              vectorA = @vectors[i % @vectors.size] + @body.p
              vectorB = @vectors[(i+1) % @vectors.size] + @body.p
              
              $window.draw_line(vectorA.x, vectorA.y, shape_color, vectorB.x, vectorB.y, shape_color) if $window
            end
          end

        else 

          case @shape
          when CP::Shape::Circle

          @image.draw_rot(position.x, position.y, @zorder, @body.a.radians_to_degrees, 0.5, 0.5, 
            @factor_x, @factor_y, @color, @mode) if @image && @visible && @body && @shape 

          when CP::Shape::Segment, CP::Shape::Poly

            if (@vectors.size == 4)
              @image.draw_rot(position.x, position.y, @zorder,  @body.a.radians_to_degrees, 0.5, 0.5, 
                @factor_x, @factor_y, @color, @mode) if @image && @visible && @body && @shape
            else 
              for i in 0..@vectors.size-1
                vectorA = @vectors[i] + @body.p
                vectorB = @vectors[(i+1) % @vectors.size] + @body.p

                distance = vectorA.dist(vectorB)
                vectors = [vectorA, vectorB]
                higher_vector = vectors.max_by { |x| x.y }
                lower_vector = vectors.min_by { |x| x.y }

                height = higher_vector.y - lower_vector.y                 
                angle = Math.asin(height / distance).radians_to_degrees

                if (higher_vector.x < lower_vector.x)
                  angle = -angle
                end

                center_x = (vectorA.x + vectorB.x) / 2
                center_y = (vectorA.y + vectorB.y) / 2

                # +  @body.a.radians_to_degrees
                @image.draw_rot(center_x, center_y, @zorder, angle + @body.a.radians_to_degrees, 0.5, 0.5, 
                  distance/100, @factor_y, @color, @mode) if @image && @visible && @body && @shape 
              end
            end
          end

        end
      end

      # Aplica uma força contínua no objeto.
      # Cada chamada desse método não zera as forças atuantes do corpo.
      #
      # @param [Float] force_x força que será aplicada na direção do eixo x
      # @param [Float] force_y força que será aplicada na direção do eixo y
      # @param [Float] offset_x Padrão 0. deslocamento do ponto de aplicação de força no eixo x
      # @param [Float] offset_y Padrão 0. deslocamento do ponto de aplicação de força no eixo y
      def apply_force(force_x, force_y, offset_x = 0, offset_y = 0)
        @body.apply_force(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end

      # Aplica uma força instantanea no objeto
      # A força é aplicada durante um intervalo pequeno de tempo.
      #
      # @param [Float] force_x força que será aplicada na direção do eixo x
      # @param [Float] force_y força que será aplicada na direção do eixo y
      # @param [Float] offset_x Padrão 0. deslocamento do ponto de aplicação de força no eixo x
      # @param [Float] offset_y Padrão 0. deslocamento do ponto de aplicação de força no eixo y
      def apply_impulse(force_x, force_y, offset_x = 0, offset_y = 0)
        @body.apply_impulse(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end
    end
  end
end

# classe com a trait para adicionar comportamentos físicos e para tratar inputs do jogo
# @author rafaelim, albertoueda
class PhysicObject < Chingu::BasicGameObject
  trait :physics
  include Chingu::Helpers::InputClient
    
end

class PhysicWindow < Chingu::Window

  def setup
    # TODO super
    self.caption = "TCC Demos - Alberto e Issao"
    self.input = { esc: :exit, d: :toggle_lines }

    @dt = 1.0 / 40.0
    @substeps = 6

    @info_area = Chingu::Text.create("", :x => 300, :y => 30, :color => Gosu::Color::YELLOW)    
    @feedbackMessage = ""
    TexPlay.set_options :caching => false
  end

  def toggle_lines
    $draw_segments = !$draw_segments  
  end

  def needs_cursor?   
    true
  end 

  def update
    super
    @info_area.text = info
    $space.step(@dt)
  end

  def info
    "#{@feedbackMessage}"
  end

  def draw
    super
    @info_area.draw
  end
end
