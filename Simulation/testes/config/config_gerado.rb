
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

		  Circles = []

		  Rectangles = []

		  Triangles = []

		  Segments = []
		end
