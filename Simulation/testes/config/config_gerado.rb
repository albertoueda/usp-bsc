
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(0, 10)
			  	@damping = 1
			  	@limited_space = true
			  	@object_gravity = true
			end
		  end

		  Circles = [{
				:mass => 30.0,
			    :radius => 30,
			    :factor_x => 3.0,
			    :factor_y => 3.0,
			    :x => 100,
			    :y => 100,
			    :v => vec2(0.0, 0.0),
			    :moment_inertia => 100,
			    :elasticity => 0.9,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
			    :image_name => 'cannonball2.png',
				:circle_fixed => true
			}]

		  Triangles = [ 
	      ]

		  Rectangles = [ 
		  ]

		  Segments = [ 
		  ]
		end
