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
		# Space
		@gravity_x = @builder['gravity_x'].text.to_i 
		@gravity_y = @builder['gravity_y'].text.to_i 
		@damping = @builder['damping'].text.to_i 
		@limited_space = value @builder['limited_space']
		@object_gravity = value @builder['object_gravity']

		# Circles
		@circle_qtde = @builder['circle_qtde'].text.to_i
		@circle_x = Array.new(@circle_qtde)
		@circle_y = Array.new(@circle_qtde)
		@circle_vx = Array.new(@circle_qtde)
		@circle_vy = Array.new(@circle_qtde)
		@circle_radius = Array.new(@circle_qtde)
		@circle_fixed = Array.new(@circle_qtde)
		@circle_m = Array.new(@circle_qtde)
		@circle_moment = Array.new(@circle_qtde)
		@circle_e = Array.new(@circle_qtde)
		@circle_u = Array.new(@circle_qtde)
		@circle_image = Array.new(@circle_qtde)
		@circle_zorder = Array.new(@circle_qtde)
		@circle_id = Array.new(@circle_qtde)

		for i in 0..@circle_qtde.to_i-1
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


		# File
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

		  Triangles = [ 
	      ]

		  Rectangles = [ 
		  ]

		  Segments = [ 
		  ]
		end"

		File.open('testes/config/config_gerado.rb', 'w') do |file|  
		  file.puts file_content
		end

		system('ruby', "./testes/Test.rb")

	end

	def value(checkbutton) 
		checkbutton.state.name.end_with?("ACTIVE")
	end

	def config_circles
		circles = ""
		
		for i in 0..@circle_qtde-1 
			circles += "{
				:mass => #{@circle_m[i]},
			    :radius => #{@circle_radius[i]},
			    :factor_x => #{@circle_radius[i] / 10.0},
			    :factor_y => #{@circle_radius[i] / 10.0},
			    :x => #{@circle_x[i]},
			    :y => #{@circle_y[i]},
			    :v => vec2(#{@circle_vx[0]}, #{@circle_vy[0]}),
			    :moment_inertia => #{@circle_moment[i]},
			    :elasticity => #{@circle_e[i]},
			    :friction => #{@circle_u[i]},
			    :zorder => #{@circle_zorder[i]},
			    :collision_type => #{@circle_id[i]},
			    :image_name => #{@circle_image[i]},
				:circle_fixed => #{@circle_fixed[i]}
			}"

			circles += ", " if i != @circle_qtde-1
		end

		circles
	end
end
