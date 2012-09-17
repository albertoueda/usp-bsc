require 'rubygems'
require 'chipmunk'
require 'chingu'
require 'gosu'


include CP
include Chingu

$space = Space.new

module Chingu
  module Traits
    module Physics

      include Chingu::Helpers::RotationCenter

      attr_accessor :factor_x, :factor_y, :center_x, :center_y, :zorder, :mode, :color
      attr_reader :factor, :center, :height, :width, :image
      attr_accessor :visible

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

        body = Body.new(options[:mass], options[:moment_inertia])
        body.p = vec2(options[:x], options[:y]) 
        body.add_to_space($space)

        @shape = Shape::Circle.new(body, options[:radius], Vec2::ZERO)
        @shape.body.a = options[:angle] || 0
        @shape.body.w = options[:velocity_angle] || 0
        @shape.add_to_space($space)
        super(options)
      end

      # Quick way of setting both factor_x and factor_y
      def factor=(factor)
        @factor = @factor_x = @factor_y = factor
      end
      
      def body 
        @shape.body
      end

      def force
        @shape.body.f
      end

      def force=(force)
        @shape.body.f = force
      end

      def moment_inertia
        @shape.body.i
      end

      def moment_inertia=(moment_inertia)
        @shape.body.i = moment_inertia
      end

      def mass
        @shape.body.m
      end

      def mass=(mass)
        @shape.body.m = mass
      end

      def x
        @shape.body.p.x
      end

      def x=(x)
        @shape.body.p.x = x
        super(x)
      end

      def y
        @shape.body.p.y
      end

      def y=(y)
        @shape.body.p.y = y
        super(y)
      end

      def velocity_x
        @shape.body.v.x
      end

      def velocity_x=(velocity_x)
        @shape.body.v.x = velocity_x
      end

      def velocity_y
        @shape.body.v.y
      end

      def velocity_y=(velocity_y)
        @shape.body.v.y = velocity_y
      end

      def velocity_angle=(velocity_angle)
        @shape.body.w = velocity_angle
      end

      def velocity_angle
        @shape.body.w
      end

      def angle=(angle)
        @shape.body.a = angle
      end

      def angle
        @shape.body.a
      end

      def draw
        @image.draw_rot(self.x, self.y, @zorder, self.angle, @center_x, @center_y, @factor_x, @factor_y, @color, @mode)  if @image
      end

      def apply_force(force_x, force_y, offset_x = 0, offset_y = 0)
        @shape.body.apply_force(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end

      def apply_impulse(force_x, force_y, offset_x = 0, offset_y = 0)
        @shape.body.apply_impulse(vec2(force_x, force_y), vec2(offset_x, offset_y))
      end
    end
  end
end

class PhysicObject < BasicGameObject
  trait :physics
  include Helpers::InputClient
end
