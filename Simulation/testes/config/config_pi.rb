
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

		  Circles = []

		  Rectangles = [{
				:mass => 60.0,
			    :x => 300,
			    :y => 400,
			    :factor_x => 16.0,
			    :factor_y => 0.8,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-40, -40), vec2(-40, 40), 
			    			 vec2(40, 40), vec2(40, -40)],
			    :angle => 0.0,
			    :moment_inertia => 6000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult.png',
				:static => false
			}, {
				:mass => 60.0,
			    :x => 400,
			    :y => 400,
			    :factor_x => 16.0,
			    :factor_y => 0.8,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-40, -40), vec2(-40, 40), 
			    			 vec2(40, 40), vec2(40, -40)],
			    :angle => 0.0,
			    :moment_inertia => 6000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'catapult.png',
				:static => false
			}, {
				:mass => 600.0,
			    :x => 350,
			    :y => 300,
			    :factor_x => 16.0,
			    :factor_y => 0.3,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-40, -15), vec2(-40, 15), 
			    			 vec2(40, 15), vec2(40, -15)],
			    :angle => 0.0,
			    :moment_inertia => 60000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
			    :image_name => 'catapult.png',
				:static => false
			}]

		  Triangles = []

		  Segments = []
		end
