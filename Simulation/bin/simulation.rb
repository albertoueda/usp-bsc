
class Simulation
	include GladeGUI

	def show
		load_glade(__FILE__)  #loads file, glade/MyClass.glade into @builder
		set_glade_all #populates glade controls with insance variables (i.e. Myclass.label1) 
    find_and_populate_demos
		show_window
	end	

  def find_and_populate_demos
    @view = VR::ListView.new(file_name: String)
    
    Dir['demos/*.rb'].each do |source|
      @view.add_row(file_name: source)
    end

    @builder['demolist'].add(@view)
  end

  def demobutton__clicked(*argv)
    return unless row = @view.selected_rows.first
    system('ruby', row[:file_name])
  end
end
