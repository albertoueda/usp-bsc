require 'rubygems'
require 'chipmunk'
require 'chingu'
require 'gosu'
require 'forwardable'

include CP
include Chingu

$space = Space.new

module Chingu
  module Traits
    module Physics
      include Chingu::Helpers::RotationCenter
      extend Forwardable

      attr_accessor :factor_x, :factor_y, :center_x, :center_y, :zorder, :mode, :color, :visible, :body
      attr_reader :factor, :center, :height, :width, :image
      def_delegator :@body, :f, :force
      def_delegator :@body, :i, :moment_inertia
      def_delegator :@body, :m, :mass
      def_delegator :@body, :w, :velocity_angle
      def_delegator :@body, :a, :angle

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

        @body = Body.new(options[:mass], options[:moment_inertia])
        @body.p = vec2(options[:x], options[:y])
        @body.add_to_space($space)

        @shape = Shape::Circle.new(@body, options[:radius], Vec2::ZERO)
        @shape.body.a = options[:angle] || 0
        @shape.body.w = options[:velocity_angle] || 0
        @shape.add_to_space($space)
        super(options)
      end

      # Quick way of setting both factor_x and factor_y
      def factor=(factor)
        @factor = @factor_x = @factor_y = factor
      end

      def position
        @body.p
      end

      def velocity
        @body.v
      end

      def draw
        @image.draw_rot(position.x, position.y, @zorder, angle, @center_x, @center_y, @factor_x, @factor_y, @color, @mode)  if @image
        
      end

      def apply_force(force_x, force_y, offset_x = 0, offset_y = 0)
        @body.apply_force(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end

      def apply_impulse(force_x, force_y, offset_x = 0, offset_y = 0)
        @body.apply_impulse(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end
    end
  end
end

class PhysicObject < BasicGameObject
  trait :physics
  include Helpers::InputClient
end
