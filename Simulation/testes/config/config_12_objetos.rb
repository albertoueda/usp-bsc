
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
				:mass => 1000.0,
			    :radius => 11,
			    :factor_x => 1.1, 
			    :factor_y => 1.1,
			    :x => 100,
			    :y => 111,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 100000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 1111.0,
			    :radius => 11,
			    :factor_x => 1.1, 
			    :factor_y => 1.1,
			    :x => 300,
			    :y => 111,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 1111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 1111.0,
			    :radius => 11,
			    :factor_x => 1.1, 
			    :factor_y => 1.1,
			    :x => 500,
			    :y => 111,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
			    :image_name => 'cannonball2.png',
				:static => true
			}]

		  Rectangles = [{
				:mass => 111.0,
			    :x => 200,
			    :y => 300,
			    :factor_x => 22.2,
			    :factor_y => 0.11,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-55, -5), vec2(-55, 5), 
			    			 vec2(55, 5), vec2(55, -5)],
			    :angle => 0.0,
			    :moment_inertia => 11111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult.png',
				:static => true
			}, {
				:mass => 1111.0,
			    :x => 400,
			    :y => 300,
			    :factor_x => 2.2,
			    :factor_y => 0.11,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-5, -5), vec2(-5, 5), 
			    			 vec2(5, 5), vec2(5, -5)],
			    :angle => 0.0,
			    :moment_inertia => 11111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'catapult.png',
				:static => false
			}, {
				:mass => 111.0,
			    :x => 600,
			    :y => 300,
			    :factor_x => 2.2,
			    :factor_y => 1.11,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-5, -55), vec2(-5, 55), 
			    			 vec2(5, 55), vec2(5, -55)],
			    :angle => 0.0,
			    :moment_inertia => 1111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
			    :image_name => 'catapult.png',
				:static => false
			}]

		  Triangles = [{
				:mass => 111.0,
			    :x => 100,
			    :y => 500,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-50, -50), vec2(0, 50), vec2(50, -50)],
			    :moment_inertia => 1111111111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
					:static => false
			}, {
				:mass => 111.0,
			    :x => 300,
			    :y => 500,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-50, -50), vec2(0, 50), vec2(50, -50)],
			    :moment_inertia => 11111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
					:static => false
			}, {
				:mass => 1111.0,
			    :x => 500,
			    :y => 500,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-50, -50), vec2(0, 50), vec2(50, -50)],
			    :moment_inertia => 111,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
					:static => true
			}]

		  Segments = [{
			    :x => 300,
			    :y => 300,
			    :thickness => 1,
			    :angle => 0.0,
			    :vectors => [vec2(-250, -250), vec2(250, 250)],
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
				:static => true
			}, {
			    :x => 500,
			    :y => 500,
			    :thickness => 1,
			    :angle => 0.0,
			    :vectors => [vec2(-250, 0), vec2(250, 0)],
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
				:static => true
			}, {
			    :x => 300,
			    :y => 300,
			    :thickness => 1,
			    :angle => 0.0,
			    :vectors => [vec2(0, -100), vec2(0, 100)],
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
				:static => true
			}]
		end
