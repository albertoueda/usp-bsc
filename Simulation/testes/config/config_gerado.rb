
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(0, 0)
			  	@damping = 1
			  	@limited_space = true
			  	@object_gravity = true
			end
		  end

		  Circles = [{
				:mass => 20,
			    :radius => 10,
			    :factor_x => 1.0,
			    :factor_y => 1.0,
			    :x => 100,
			    :y => 100,
			    :moment_inertia => 0,
			    :elasticity => 0,
			    :friction => 0,
			    :zorder => 100,
			    :collision_type => :undefined0,
				:circle_fixed => true
			    :image_name => cannonball2.png,
			}]

		  Triangles = [ 
	      ]

		  Rectangles = [ 
		  ]

		  Segments = [ 
		  ]
		end
