
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

		  Circles = []

		  Rectangles = []

		  Triangles = []

		  Segments = [{
			    :mass => CP::INFINITY,
			    :moment_inertia => CP::INFINITY,
			    :x => 300,
			    :y => 300,
			    :angle => 0.0,
			    :vectors => [vec2(0, 0), vec2(500, 500)],
			    :elasticity => 0.0,
			    :friction => 0.0,
			    :zorder => 100,
			    :collision_type => :undefined0,
				:segment_fixed => true
			}]
		end
