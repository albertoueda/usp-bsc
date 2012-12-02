
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
				:mass => 10000.0,
			    :radius => 50,
			    :factor_x => 5.0, 
			    :factor_y => 5.0,
			    :x => 400,
			    :y => 300,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 1000000000000,
			    :elasticity => 0.1,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 1000.0,
			    :radius => 10,
			    :factor_x => 1.0, 
			    :factor_y => 1.0,
			    :x => 200,
			    :y => 300,
			    :v => vec2(0.0, 100.0),
			    :moment_inertia => 10000,
			    :elasticity => 0.1,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined1,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 800.0,
				# TODO conferir se o maior tem que ser o + rapido
			    :radius => 8,
			    :factor_x => 0.8, 
			    :factor_y => 0.8,
			    :x => 600,
			    :y => 300,
			    :v => vec2(0.0, -100.0),
			    :moment_inertia => 100000000,
			    :elasticity => 0.0,
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
