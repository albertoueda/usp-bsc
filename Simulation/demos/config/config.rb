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

  Rock = {
    :x => 100,
    :y => 500,
    :radius => 10,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_circle(100, 0, 10, CP::Vec2::ZERO),
    :collision_type => :rock,
    :elasticity => 0.8,
    :friction => 0.4
  }

  Stone = {
    :x => 0,
    :y => 0,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_box(1000, 25, 25),
    :vectors => [vec2(-12.5,-12.5), vec2(-12.5,12.5), vec2(12.5,12.5), vec2(12.5,-12.5)],
    :collision_type => :stone,
    :elasticity => 0.0,
    :friction => 0.4
  }

  WoodStone = {
    :x => 0,
    :y => 0,
    :mass => 10,
    :zorder => 10,
    :moment_inertia => CP.moment_for_box(10, 25, 25),
    :vectors => [vec2(-12.5,-12.5), vec2(-12.5,12.5), vec2(12.5,12.5), vec2(12.5,-12.5)],
    :collision_type => :stone,
    :elasticity => 0.3,
    :friction => 0.4
  }

  Gem = {
    :x => 0,
    :y => 0,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_poly(100, [vec2(-12.5,-12.5), vec2(0,12.5), vec2(12.5,-12.5)], CP::Vec2::ZERO),
    :vectors => [vec2(-12.5,-12.5), vec2(0,12.5), vec2(12.5,-12.5)],
    :collision_type => :gem,
    :elasticity => 0.3,
    :friction => 0.4,
    :rotational_velocity => 20.0
  }

  GemBall = {
    :x => 0,
    :y => 0,
    :radius => 12.5,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_circle(100, 0.0, 25, CP::Vec2::ZERO),
    :collision_type => :gem,
    :elasticity => 0.3,
    :friction => 0.4,
    # :rotational_velocity => 10.0
  }
end
