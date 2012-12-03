
  require 'chipmunk'
  require 'gosu'
  
  module Config

    class Space
      attr_accessor :gravity, :damping

      def initialize
        @gravity = vec2(0, 100.0)
      end
    end

    
    Circles = [{
      :mass => 100,
      :radius => 15,
      :factor_x => 1.5, 
      :factor_y => 1.5,
      :x => 50,
      :y => 500,
      :v => vec2(400.0, -0.0),
      :moment_inertia => 100000,
      :elasticity => 0.8,
      :friction => 0.8,
      :collision_type => :bixo,
      :image_name => 'cannonball2.png',
    }] 
     
    Rectangles = [{
      :x => 750,
      :y => 400,
      :vectors => [vec2(-30, -60), vec2(-30, 60), 
                   vec2(30, 60), vec2(30, -60)],
      :elasticity => 0.8,
      :friction => 0.8,
      :collision_type => :alvo,
      :image_name => 'target.png',
      :factor_x => 1.5,
      :factor_y => 2.0,
      :static => true
    }] 
  end
