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
    :x => 100,
    :y => 100,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_box(100, 40, 90),
    :vectors => [vec2(-20,-40), vec2(-20,40), vec2(20,40), vec2(20,-40)],
  	:collision_type => :rocket,
  	:elasticity => 0.0,
  	:friction => 0.4
  }

end
