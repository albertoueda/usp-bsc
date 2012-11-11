
class ScenarioCreator
	include GladeGUI

	def show
		load_glade(__FILE__)  #loads file, glade/MyClass.glade into @builder
		set_glade_all #populates glade controls with insance variables (i.e. Myclass.label1) 
		show_window
	end	

	def demobutton__clicked(*argv)
	@mass = @builder['mass'].text.to_i
	@radius = @builder['radius'].text.to_i

	file_content = 
	"module TestObjectConfig

	  Circles = [ 
	  	Rock = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 400,
		    :y => 300,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		},
		Rock2 = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 100,
		    :y => 300,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		}
	  ]

	  Triangles = [ 
	  	T = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 500,
		    :y => 300,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		},
		T2 = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 500,
		    :y => 300,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		}
      ]

	  Rectangles = [ 
	  	R = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 400,
		    :y => 500,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		},
		R2 = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 100,
		    :y => 500,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		}
	  ]
	  
	  Segments = [ 
	  	S = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 400,
		    :y => 600,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		},
		S2 = {
			:mass => #{@mass},
		    :radius => #{@radius},
		    :factor_x => #{@radius / 10.0},
		    :factor_y => #{@radius / 10.0},
		    :x => 100,
		    :y => 600,
		    :zorder => 1,
		    :moment_inertia => 0.0001,
		    :collision_type => :ball,
		    :elasticity => 0.9,
		    :friction => 0.3,
		    :image_name => 'cannonball2.png'
		}
	  ]
	end"

	File.open('testes/config/config_gerado.rb', 'w') do |file|  
	  file.puts file_content
	end

	system('ruby', "./testes/Test.rb")

	end
end
