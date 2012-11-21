
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(0, 0)
			  	@damping = 1.0
			  	@limited_space = false
			  	@object_gravity = true
			end
		  end

		  Circles = [{
				:mass => 2500000.0,
			    :radius => 50,
			    :factor_x => 5.0, 
			    :factor_y => 5.0,
			    :x => 350,
			    :y => 250,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 1000000,
			    :elasticity => 1,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 400000.0,
			    :radius => 20,
			    :factor_x => 2.0, 
			    :factor_y => 2.0,
			    :x => 400,
			    :y => 100,
			    :v => vec2(-80.0, 0.0),
			    :moment_inertia => 100000,
			    :elasticity => 1,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 100000.0,
			    :radius => 10,
			    :factor_x => 1.0, 
			    :factor_y => 1.0,
			    :x => 300,
			    :y => 400,
			    :v => vec2(200.0, 0.0),
			    :moment_inertia => 100000,
			    :elasticity => 1,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined2,
			    :image_name => 'cannonball2.png',
				:static => false
			}]

		  Rectangles = []

		  Triangles = []

		  Segments = []
		end
