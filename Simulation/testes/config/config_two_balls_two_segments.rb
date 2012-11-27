
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
				:mass => 100.0,
			    :radius => 20,
			    :factor_x => 2.0, 
			    :factor_y => 2.0,
			    :x => 200,
			    :y => 100,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 100000,
			    :elasticity => 1.0,
			    :friction => 1.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 100.0,
			    :radius => 20,
			    :factor_x => 2.0, 
			    :factor_y => 2.0,
			    :x => 400,
			    :y => 100,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 100000,
			    :elasticity => 1.0,
			    :friction => 1.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'cannonball2.png',
				:static => false
			}]

		  Rectangles = []

		  Triangles = []

		  Segments = [{
			    :x => 200,
			    :y => 400,
			    :thickness => 1,
			    :angle => 0.0,
			    :vectors => [vec2(-150, -100), vec2(150, 100)],
			    :elasticity => 1.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult.png',
				:static => true
			}, {
			    :x => 400,
			    :y => 400,
			    :thickness => 1,
			    :angle => 0.0,
			    :vectors => [vec2(-150, 100), vec2(150, -100)],
			    :elasticity => 0.0,
			    :friction => 1.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'catapult.png',
				:static => true
			}]
		end
