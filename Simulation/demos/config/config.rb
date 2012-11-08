require 'chipmunk'
require 'gosu'

module ObjectConfig

  Ball = {
    :x => 0,
    :y => 0,
    :zorder => 1,
    :radius => 25.0/2.0,
    :mass => 1,
    :moment_inertia => 0.0001,
    :collision_type => :ball,
    :elasticity => 0.1,
    :friction => 1.0,
    :image_name => "cannonball2.png"      
  }  

  Rocket = {
    :x => 70,
    :y => 300,
    :mass => 10000,
    :moment_inertia => 10,
    :radius => 10,
    :image_name => "rocket.png"
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
    :friction => 0.4,
    :image_name => "spaceship.png"
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
    :friction => 0.4,
    :image_name => "cannonball2.png"
  }

  Stone = {
    :x => 0,
    :y => 0,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_box(100, 25, 25),
    :vectors => [vec2(-12.5,-12.5), vec2(-12.5,12.5), vec2(12.5,12.5), vec2(12.5,-12.5)],
    :collision_type => :stone,
    :elasticity => 0.0,
    :friction => 0.7,
    :image_name => "stone.png"
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
    :friction => 0.4,
    :image_name => "woodstone.png"
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
    :rotational_velocity => 40.0,
    :shape_color => Gosu::Color::RED,
    :image_name => "gem.png"
  }

  GemBall = {
    :x => 0,
    :y => 0,
    :radius => 12.5,
    :mass => 100,
    :zorder => 10,
    :moment_inertia => CP.moment_for_circle(100, 0.0, 25, CP::Vec2::ZERO),
    :collision_type => :gem,
    :elasticity => 0.6,
    :friction => 0.4,
    :shape_color => Gosu::Color::RED,
    :image_name => "gem-ball.png"
    # :rotational_velocity => 10.0
  }
end
