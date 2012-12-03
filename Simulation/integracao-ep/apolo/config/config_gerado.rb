
  require 'chipmunk'
  require 'gosu'
  
  module Config
    
    Circles = [{
      :mass => 10000,
      :radius => 20,
      :factor_x => 0.5, 
      :factor_y => 0.5,
      :center_x => 1.0,
      :center_y => 1.0,
      :x => 200.0,
      :y => 140.0,
      :v => vec2(80.0, 25.0),
      :moment_inertia => 100000,
      :collision_type => :nave,
      :image_name => 'rocket.png',
    }, {
      :radius => 10,
      :factor_x => 1, 
      :factor_y => 1,
      :x => 600,
      :y => 300,
      :collision_type => :lua,
      :image_name => 'cannonball2.png',
      :static => true
    }, {
      :radius => 50,
      :factor_x => 1/5.0, 
      :factor_y => 1/5.0,
      :x => 150,
      :y => 300,
      :collision_type => :terra,
      :image_name => 'globe.png',
      :static => true
    }]
  end
