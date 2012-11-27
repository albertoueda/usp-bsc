
        require 'chipmunk'
        require 'gosu'
        
        module TestObjectConfig

          class Space
            attr_accessor :gravity, :damping, :limited_space, :object_gravity

            def initialize
                @gravity = vec2(0, 100)
                @damping = 1
                @limited_space = true
                @object_gravity = false
            end
          end

          Circles = [{
                :mass => 10.0,
                :radius => 10,
                :factor_x => 1.0, 
                :factor_y => 1.0,
                :x => 100,
                :y => 100,
                :v => vec2(0.0, 0.0),
                :moment_inertia => 100000,
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined0,
                :image_name => 'cannonball2.png',
                :static => true
            }, {
                :mass => 30.0,
                :radius => 30,
                :factor_x => 3.0, 
                :factor_y => 3.0,
                :x => 200,
                :y => 100,
                :v => vec2(0.0, 0.0),
                :moment_inertia => 30,
                :elasticity => 0.5,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined1,
                :image_name => 'cannonball2.png',
                :static => false
            }]

          Rectangles = [{
                :mass => 10.0,
                :x => 100,
                :y => 200,
                :factor_x => 6.0,
                :factor_y => 0.5,
                :v => vec2(0.0, 0.0),
                :vectors => [vec2(-15, -25), vec2(-15, 25), 
                             vec2(15, 25), vec2(15, -25)],
                :angle => 20.0,
                :moment_inertia => 30000,
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined0,
                :image_name => 'catapult.png',
                :static => true
            }, {
                :mass => 30.0,
                :x => 300,
                :y => 200,
                :factor_x => 16.0,
                :factor_y => 0.2,
                :v => vec2(0.0, 0.0),
                :vectors => [vec2(-40, -10), vec2(-40, 10), 
                             vec2(40, 10), vec2(40, -10)],
                :angle => -30.0,
                :moment_inertia => 30000,
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined1,
                :image_name => 'catapult.png',
                :static => false
            }]

          Triangles = [{
                :mass => 100.0,
                :x => 200,
                :y => 300,
                :v => vec2(0.0, 0.0),
                :vectors => [vec2(-50, -50), vec2(0, 50), vec2(50, -50)],
                :moment_inertia => 10000,
                :elasticity => 0.9,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined0,
                :image_name => 'catapult.png',
                :static => true
            }, {
                :mass => 4000.0,
                :x => 500,
                :y => 300,
                :v => vec2(0.0, 0.0),
                :vectors => [vec2(-50, 50), vec2(50, 50), vec2(0, -100)],
                :moment_inertia => 400000,
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined1,
                :image_name => 'catapult.png',
                :static => false
            }]

          Segments = [{
                :x => 200,
                :y => 200,
                :thickness => 1,
                :angle => 0.0,
                :vectors => [vec2(-50, -10), vec2(50, 10)],
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined0,
                :static => true
            }, {
                :x => 300,
                :y => 400,
                :thickness => 1,
                :angle => 0.0,
                :vectors => [vec2(-40, -70), vec2(100, 70)],
                :elasticity => 0.0,
                :friction => 0.0,
                :zorder => 100,
                :collision_type => :undefined1,
                :static => true
            }]
        end
