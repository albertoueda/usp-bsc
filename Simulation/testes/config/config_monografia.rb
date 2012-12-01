
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
				:mass => 30.0,
			    :radius => 30,
			    :factor_x => 3.0, 
			    :factor_y => 3.0,
			    :x => 350,
			    :y => 100,
			    :v => vec2(20.0, 0.0),
			    :moment_inertia => 3000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}]

		  Rectangles = [{
				:mass => 0.0,
			    :x => 80,
			    :y => 200,
			    :factor_x => 24.0,
			    :factor_y => 0.6,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-60, -30), vec2(-60, 30), 
			    			 vec2(60, 30), vec2(60, -30)],
			    :angle => 0.0,
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult.png',
				:static => true
			}, {
				:mass => 0.0,
			    :x => 350,
			    :y => 200,
			    :factor_x => 32.0,
			    :factor_y => 0.6,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-80, -30), vec2(-80, 30), 
			    			 vec2(80, 30), vec2(80, -30)],
			    :angle => 0.0,
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'catapult.png',
				:static => true
			}, {
				:mass => 0.0,
			    :x => 400,
			    :y => 400,
			    :factor_x => 12.0,
			    :factor_y => 0.6,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-30, -30), vec2(-30, 30), 
			    			 vec2(30, 30), vec2(30, -30)],
			    :angle => 0.0,
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
			    :image_name => 'catapult.png',
				:static => true
			}, {
				:mass => 0.0,
			    :x => 720,
			    :y => 400,
			    :factor_x => 24.0,
			    :factor_y => 0.6,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(-60, -30), vec2(-60, 30), 
			    			 vec2(60, 30), vec2(60, -30)],
			    :angle => 0.0,
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined3,
			    :image_name => 'catapult.png',
				:static => true
			}]

		  Triangles = [{
				:mass => 0.0,
			    :x => 600,
			    :y => 520,
			    :v => vec2(0.0, 0.0),
			    :vectors => [vec2(0, -50), vec2(-100, 50), vec2(100, 50)],
			    :moment_inertia => 0,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'catapult-b.png',
				:static => true
			}]

		  Segments = []
		end
