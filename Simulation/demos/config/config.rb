require 'chipmunk'

module ObjectConfig

  Rocket = {
    :x => 70,
    :y => 300,
    :mass => 10000,
    :moment_inertia => 10,
    :radius => 10
  }

  LunarRocket = {
    :x => 50,
    :y => 200,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_box(100, 100, 100),
    :vectors => [vec2(-20,-45), vec2(-20,45), vec2(20,45), vec2(20,-45)],
  	:collision_type => :rocket,
  	:e => 1.0,
  	:u => 1.0
  }

end
