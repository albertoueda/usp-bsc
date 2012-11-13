
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
				:mass => 40,
			    :radius => 30,
			    :factor_x => 3.0,
			    :factor_y => 3.0,
			    :x => 30,
			    :y => 30,
			    :moment_inertia => 0,
			    :collision_type => :undefined0,
			    :elasticity => 0,
			    :friction => 0,
			    :zorder => 20,
				:circle_fixed => true
			}, {
				:mass => 20,
			    :radius => 30,
			    :factor_x => 3.0,
			    :factor_y => 3.0,
			    :x => 0,
			    :y => 0,
			    :moment_inertia => 0,
			    :collision_type => :undefined1,
			    :elasticity => 0,
			    :friction => 0,
			    :zorder => 20,
				:circle_fixed => true
			}]

		  Triangles = [ 
	      ]

		  Rectangles = [ 
		  ]

		  Segments = [ 
		  ]
		end
