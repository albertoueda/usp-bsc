
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
				:mass => 30000.0,
			    :radius => 60,
			    :factor_x => 6.0, 
			    :factor_y => 6.0,
			    :x => 400,
			    :y => 400,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 4000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :Sol,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 4350.0,
			    :radius => 10,
			    :factor_x => 1.0, 
			    :factor_y => 1.0,
			    :x => 700,
			    :y => 400,
			    :v => vec2(0.0, -112.0),
			    :moment_inertia => 4000000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :Terra,
			    :image_name => 'cannonball2.png',
				:static => false
			}, {
				:mass => 500.0,
			    :radius => 5,
			    :factor_x => 0.5, 
			    :factor_y => 0.5,
			    :x => 720,
			    :y => 400,
			    :v => vec2(0.0, 10.0),
			    :moment_inertia => 1000,
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :Lua,
			    :image_name => 'cannonball2.png',
				:static => false
			}]

		  Rectangles = []

		  Triangles = []

		  Segments = []
		end
