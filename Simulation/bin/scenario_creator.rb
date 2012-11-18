require 'chipmunk'
require 'gosu'

class ScenarioCreator
	include GladeGUI

	def show
		load_glade(__FILE__)  #loads file, glade/MyClass.glade into @builder
		set_glade_all #populates glade controls with insance variables (i.e. Myclass.label1) 
		show_window
	end	

	def demobutton__clicked(*argv)
		@selected_config_file = @builder['input_file_button'].filename

		if (@selected_config_file)
			use_config_file
		else
			read_space_data
			read_circles_data
			read_rectangles_data
			read_triangles_data
			read_segments_data
			generate_config_file
		end

		run_simulation
	end

	def read_space_data

		@gravity_x = @builder['gravity_x'].text.to_i 
		@gravity_y = @builder['gravity_y'].text.to_i 
		@damping = @builder['damping'].text.to_f
		@limited_space = value @builder['limited_space']
		@object_gravity = value @builder['object_gravity']
	end

	def read_circles_data

		@num_circles = @builder['circles_qtde'].text.to_i
		@circle_x = Array.new(@num_circles)
		@circle_y = Array.new(@num_circles)
		@circle_vx = Array.new(@num_circles)
		@circle_vy = Array.new(@num_circles)
		@circle_radius = Array.new(@num_circles)
		@circle_fixed = Array.new(@num_circles)
		@circle_m = Array.new(@num_circles)
		@circle_moment = Array.new(@num_circles)
		@circle_e = Array.new(@num_circles)
		@circle_u = Array.new(@num_circles)
		@circle_image = Array.new(@num_circles)
		@circle_zorder = Array.new(@num_circles)
		@circle_id = Array.new(@num_circles)

		for i in 0..@num_circles.to_i-1
			@circle_radius[i] = @builder['circle_radius_' + i.to_s].text.to_i  
			@circle_x[i] = @builder['circle_x_' + i.to_s].text.to_i  
			@circle_y[i] = @builder['circle_y_' + i.to_s].text.to_i  
			@circle_vx[i] = @builder['circle_vx_' + i.to_s].text.to_f 
			@circle_vy[i] = @builder['circle_vy_' + i.to_s].text.to_f  
			@circle_m[i] = @builder['circle_m_' + i.to_s].text.to_f  
			@circle_e[i] = @builder['circle_e_' + i.to_s].text.to_f   
			@circle_u[i] = @builder['circle_u_' + i.to_s].text.to_f  
			@circle_moment[i] = @builder['circle_moment_' + i.to_s].text.to_i  
			@circle_fixed[i] = value @builder['circle_fixed_' + i.to_s]  
			@circle_id[i] = @builder['circle_id_' + i.to_s].text.empty? ? ":undefined#{i}" : ":" + @builder['circle_id_' + i.to_s].text 
			@circle_zorder[i] = 100
			@circle_image[i] = "'cannonball2.png'"  
			# @circle_image[i] = @builder['circle_image_' + i.to_s].text  
		end
	end

	def read_rectangles_data

		@num_rectangles = @builder['rectangles_qtde'].text.to_i
		@rec_x = Array.new(@num_rectangles)
		@rec_y = Array.new(@num_rectangles)
		@rec_vx = Array.new(@num_rectangles)
		@rec_vy = Array.new(@num_rectangles)
		@rec_height = Array.new(@num_rectangles)
		@rec_width = Array.new(@num_rectangles)
		@rec_angle = Array.new(@num_rectangles)
		@rec_fixed = Array.new(@num_rectangles)
		@rec_m = Array.new(@num_rectangles)
		@rec_moment = Array.new(@num_rectangles)
		@rec_e = Array.new(@num_rectangles)
		@rec_u = Array.new(@num_rectangles)
		@rec_image = Array.new(@num_rectangles)
		@rec_zorder = Array.new(@num_rectangles)
		@rec_id = Array.new(@num_rectangles)

		for i in 0..@num_rectangles.to_i-1
			@rec_x[i] = @builder['rec_x_' + i.to_s].text.to_i  
			@rec_y[i] = @builder['rec_y_' + i.to_s].text.to_i  
			@rec_vx[i] = @builder['rec_vx_' + i.to_s].text.to_f 
			@rec_vy[i] = @builder['rec_vy_' + i.to_s].text.to_f  
			@rec_angle[i] = @builder['rec_angle_' + i.to_s].text.to_f  
			@rec_height[i] = @builder['rec_height_' + i.to_s].text.to_i  
			@rec_width[i] = @builder['rec_width_' + i.to_s].text.to_i  
			@rec_m[i] = @builder['rec_m_' + i.to_s].text.to_f  
			@rec_e[i] = @builder['rec_e_' + i.to_s].text.to_f   
			@rec_u[i] = @builder['rec_u_' + i.to_s].text.to_f  
			@rec_moment[i] = @builder['rec_moment_' + i.to_s].text.to_i  
			@rec_fixed[i] = value @builder['rec_fixed_' + i.to_s]  
			@rec_id[i] = @builder['rec_id_' + i.to_s].text.empty? ? ":undefined#{i}" : ":" + @builder['rec_id_' + i.to_s].text 
			@rec_image[i] = "'catapult.png'"
			@rec_zorder[i] = 100
		end
	end

	def read_triangles_data

		@num_triangles = @builder['triangles_qtde'].text.to_i
		@triangle_x = Array.new(@num_triangles)
		@triangle_y = Array.new(@num_triangles)
		@triangle_vx = Array.new(@num_triangles)
		@triangle_vy = Array.new(@num_triangles)
		@triangle_a = Array.new(@num_triangles)
		@triangle_b = Array.new(@num_triangles)
		@triangle_c = Array.new(@num_triangles)
		@triangle_fixed = Array.new(@num_triangles)
		@triangle_m = Array.new(@num_triangles)
		@triangle_moment = Array.new(@num_triangles)
		@triangle_e = Array.new(@num_triangles)
		@triangle_u = Array.new(@num_triangles)
		@triangle_image = Array.new(@num_triangles)
		@triangle_zorder = Array.new(@num_triangles)
		@triangle_id = Array.new(@num_triangles)

		for i in 0..@num_triangles.to_i-1
			@triangle_x[i] = @builder['triangle_x_' + i.to_s].text.to_i  
			@triangle_y[i] = @builder['triangle_y_' + i.to_s].text.to_i  
			@triangle_vx[i] = @builder['triangle_vx_' + i.to_s].text.to_f 
			@triangle_vy[i] = @builder['triangle_vy_' + i.to_s].text.to_f  
			@triangle_a[i] = @builder['triangle_ax_' + i.to_s].text + ", " + @builder['triangle_ay_' + i.to_s].text  
			@triangle_b[i] = @builder['triangle_bx_' + i.to_s].text + ", " + @builder['triangle_by_' + i.to_s].text    
			@triangle_c[i] = @builder['triangle_cx_' + i.to_s].text + ", " + @builder['triangle_cy_' + i.to_s].text    
			@triangle_m[i] = @builder['triangle_m_' + i.to_s].text.to_f  
			@triangle_e[i] = @builder['triangle_e_' + i.to_s].text.to_f   
			@triangle_u[i] = @builder['triangle_u_' + i.to_s].text.to_f  
			@triangle_moment[i] = @builder['triangle_moment_' + i.to_s].text.to_i  
			@triangle_fixed[i] = value @builder['triangle_fixed_' + i.to_s]  
			@triangle_id[i] = @builder['triangle_id_' + i.to_s].text.empty? ? ":undefined#{i}" : ":" + @builder['triangle_id_' + i.to_s].text 
			@triangle_image[i] = "'catapult.png'"
			@triangle_zorder[i] = 100
		end
	end

	def read_segments_data

		@num_segments = @builder['segments_qtde'].text.to_i
		@segment_x = Array.new(@num_segments)
		@segment_y = Array.new(@num_segments)
		@segment_a = Array.new(@num_segments)
		@segment_b = Array.new(@num_segments)
		@segment_angle = Array.new(@num_segments)
		@segment_e = Array.new(@num_segments)
		@segment_u = Array.new(@num_segments)
		@segment_image = Array.new(@num_segments)
		@segment_zorder = Array.new(@num_segments)
		@segment_id = Array.new(@num_segments)

		for i in 0..@num_segments.to_i-1
			@segment_x[i] = @builder['segment_x_' + i.to_s].text.to_i  
			@segment_y[i] = @builder['segment_y_' + i.to_s].text.to_i  
			@segment_a[i] = @builder['segment_ax_' + i.to_s].text + ", " + @builder['segment_ay_' + i.to_s].text  
			@segment_b[i] = @builder['segment_bx_' + i.to_s].text + ", " + @builder['segment_by_' + i.to_s].text    
			@segment_angle[i] = @builder['segment_angle_' + i.to_s].text.to_f  
			@segment_e[i] = @builder['segment_e_' + i.to_s].text.to_f   
			@segment_u[i] = @builder['segment_u_' + i.to_s].text.to_f  
			@segment_id[i] = @builder['segment_id_' + i.to_s].text.empty? ? ":undefined#{i}" : ":" + @builder['segment_id_' + i.to_s].text 
			# @segment_image[i] = @builder['segment_image_' + i.to_s].text  
			@segment_zorder[i] = 100
		end
	end

	def generate_config_file

		file_content = "
		require 'chipmunk'
		require 'gosu'
		
		module TestObjectConfig

		  class Space
	  		attr_accessor :gravity, :damping, :limited_space, :object_gravity

	  		def initialize
			  	@gravity = vec2(#{@gravity_x}, #{@gravity_y})
			  	@damping = #{@damping}
			  	@limited_space = #{@limited_space}
			  	@object_gravity = #{@object_gravity}
			end
		  end

		  Circles = [" +
		  	config_circles + 	
		  "]

		  Rectangles = [" +
		  	config_rectangles + 	
		  "]

		  Triangles = [" +
		  	config_triangles + 	
		  "]

		  Segments = [" +
		  	config_segments + 	
		  "]
		end"

		File.open('testes/config/config_gerado.rb', 'w') do |file|  
		  file.puts file_content
		end	
	end

	def use_config_file
		system('cp', @selected_config_file, "testes/config/config_gerado.rb")

		# File.open('testes/config/config_gerado.rb', 'w') do |file|  
		#   file.puts file_content
		# end
	end

	def run_simulation
		system('ruby', "./testes/Test.rb")
	end

	def value(checkbutton) 
		checkbutton.state.name.end_with?("ACTIVE")
	end

	# TODO x-factor
	def config_circles
		circles = ""
		
		for i in 0..@num_circles-1 
			circles += "{
				:mass => #{@circle_m[i]},
			    :radius => #{@circle_radius[i]},
			    :factor_x => #{@circle_radius[i] / 10.0}, 
			    :factor_y => #{@circle_radius[i] / 10.0},
			    :x => #{@circle_x[i]},
			    :y => #{@circle_y[i]},
			    :v => vec2(#{@circle_vx[i]}, #{@circle_vy[i]}),
			    :moment_inertia => #{@circle_moment[i]},
			    :elasticity => #{@circle_e[i]},
			    :friction => #{@circle_u[i]},
			    :zorder => #{@circle_zorder[i]},
			    :collision_type => #{@circle_id[i]},
			    :image_name => #{@circle_image[i]},
				:static => #{@circle_fixed[i]}
			}"

			circles += ", " if i != @num_circles-1
		end

		circles
	end

	def config_rectangles
		rectangles = ""
		
		for i in 0..@num_rectangles-1 
			    # :factor_x => #{@rec_height[i]},
			    # :factor_y => #{@rec_width[i]},
			rectangles += "{
				:mass => #{@rec_m[i]},
			    :x => #{@rec_x[i]},
			    :y => #{@rec_y[i]},
			    :factor_x => #{@rec_width[i] / 5.0},
			    :factor_y => #{@rec_height[i] / 100.0},
			    :v => vec2(#{@rec_vx[i]}, #{@rec_vy[i]}),
			    :vectors => [vec2(-#{@rec_width[i]/2}, -#{@rec_height[i]/2}), vec2(-#{@rec_width[i]/2}, #{@rec_height[i]/2}), 
			    			 vec2(#{@rec_width[i]/2}, #{@rec_height[i]/2}), vec2(#{@rec_width[i]/2}, -#{@rec_height[i]/2})],
			    :angle => #{@rec_angle[i]},
			    :moment_inertia => #{@rec_moment[i]},
			    :elasticity => #{@rec_e[i]},
			    :friction => #{@rec_u[i]},
			    :zorder => #{@rec_zorder[i]},
			    :collision_type => #{@rec_id[i]},
			    :image_name => #{@rec_image[i]},
				:static => #{@rec_fixed[i]}
			}"

			rectangles += ", " if i != @num_rectangles-1
		end

		rectangles
	end

	def config_triangles
		triangles = ""
		
		for i in 0..@num_triangles-1 
			triangles += "{
				:mass => #{@triangle_m[i]},
			    :x => #{@triangle_x[i]},
			    :y => #{@triangle_y[i]},
			    :v => vec2(#{@triangle_vx[i]}, #{@triangle_vy[i]}),
			    :vectors => [vec2(#{@triangle_a[i]}), vec2(#{@triangle_b[i]}), vec2(#{@triangle_c[i]})],
			    :moment_inertia => #{@triangle_moment[i]},
			    :elasticity => #{@triangle_e[i]},
			    :friction => #{@triangle_u[i]},
			    :zorder => #{@triangle_zorder[i]},
			    :collision_type => #{@triangle_id[i]},
			    :image_name => #{@triangle_image[i]},
				:static => #{@triangle_fixed[i]}
			}"

			triangles += ", " if i != @num_triangles-1

		end

		triangles
	end

	def config_segments
		segments = ""
		
		for i in 0..@num_segments-1   # TODO Infinity
			segments += "{
			    :x => #{@segment_x[i]},
			    :y => #{@segment_y[i]},
			    :thickness => 1,
			    :angle => #{@segment_angle[i]},
			    :vectors => [vec2(#{@segment_a[i]}), vec2(#{@segment_b[i]})],
			    :elasticity => #{@segment_e[i]},
			    :friction => #{@segment_u[i]},
			    :zorder => #{@segment_zorder[i]},
			    :collision_type => #{@segment_id[i]},
				:static => true
			}"
			    # :image_name => #{@segment_image[i]},

			segments += ", " if i != @num_segments-1

		end

		segments
	end


	##### Component Handlers #####

	def update_circle_objects(spinbutton)
		update_objects(spinbutton, 'circle')
	end

	def update_triangle_objects(spinbutton)
		update_objects(spinbutton, 'triangle')
	end

	def update_rectangle_objects(spinbutton)
		update_objects(spinbutton, 'rectangle')
	end

	def update_segment_objects(spinbutton)
		update_objects(spinbutton, 'segment')
	end

	def update_objects(spinbutton, object)
		num_objects = spinbutton.value_as_int
 		num_objects == 0 ? @builder[object + 's_hbox'].hide : @builder[object + 's_hbox'].show 
		
		for i in 0..2
			if i < num_objects
				@builder[object + '_table_' + i.to_s].show 
				@builder[object + '_table_sep_' + i.to_s].show
			else
				@builder[object + '_table_' + i.to_s].hide
				@builder[object + '_table_sep_' + i.to_s].hide
			end
		end

	end

	def hide_hbox
		num_circles = @builder['circles_qtde'].value_as_int 
		@builder['circles_hbox'].hide if num_circles == 0

		num_triangle = @builder['triangles_qtde'].value_as_int 
		@builder['triangles_hbox'].hide if num_triangle == 0

		num_rectangles = @builder['rectangles_qtde'].value_as_int 
		@builder['rectangles_hbox'].hide if num_rectangles == 0

		num_segments = @builder['segments_qtde'].value_as_int 
		@builder['segments_hbox'].hide if num_segments == 0
	end
end
