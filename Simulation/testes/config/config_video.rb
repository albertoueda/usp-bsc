
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(0, 100)
			  	@damping = 1.0
			  	@limited_space = true
			  	@object_gravity = false
			end
		  end

		  Circles = [{
				:mass => 10.0,
			    :radius => 10,
			    :factor_x => 1.0, 
			    :factor_y => 1.0,
			    :x => 100,
			    :y => 100,
			    :v => vec2(100.0, 0.0),
			    :moment_inertia => 10,
			    :elasticity => 0.8,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}]

		  Rectangles = [{
				:mass => 0.0,
			    :x => 300,
			    :y => 300,
			    :factor_x => 20.0,
			    :factor_y => 0.3,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-50, -15), vec2(-50, 15), 
			    			 vec2(50, 15), vec2(50, -15)],
			    :angle => 0.0,
			    :moment_inertia => 0,
			    :elasticity => 0.5,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult.png',
				:static => true
			}]

		  Triangles = [{
				:mass => 100.0,
			    :x => 600,
			    :y => 500,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-50, 50), vec2(50, 50), vec2(0, -50)],
			    :moment_inertia => 10000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
					:static => false
			}]

		  Segments = []
		end
