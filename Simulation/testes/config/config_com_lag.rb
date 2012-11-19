
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(0, 10)
			  	@damping = 1.0
			  	@limited_space = true
			  	@object_gravity = true
			end
		  end

		  Circles = [{
				:mass => 50.0,
			    :radius => 50,
			    :factor_x => 5.0, 
			    :factor_y => 5.0,
			    :x => 200,
			    :y => 200,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 500000,
			    :elasticity => 0.9,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 30.0,
			    :radius => 20,
			    :factor_x => 2.0, 
			    :factor_y => 2.0,
			    :x => 300,
			    :y => 300,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 30000,
			    :elasticity => 1.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 200.0,
			    :radius => 10,
			    :factor_x => 1.0, 
			    :factor_y => 1.0,
			    :x => 300,
			    :y => 400,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 20000,
			    :elasticity => 1.0,
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
