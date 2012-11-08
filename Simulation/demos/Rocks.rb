#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative 'lib/physics'

class Rock < PhysicObject

  def restart
    @body.p = vec2(100, 200)  
    @body.v = CP::Vec2::ZERO
    @body.a = 0 
    @body.w = 0 
    @engaged = true
  end

  def shoot(x, y, catapult)
    center_x = 100
    center_y = 400

    # Verificar física!
    # distance = Math::Sqrt((x-center_x)**2 + (y-center_y)**2)
    k = 40
    apply_impulse(k/2.0*(center_x-x)*(x-center_x).abs, k/2.0*(center_y-y)*(y-center_y).abs)
  end

end

class Stone < PhysicObject
end

class WoodStone < PhysicObject
end

class GemStone < PhysicObject
end

class GemBallStone < PhysicObject
end

class RocksSimulation < PhysicWindow

  def setup
    super
    self.caption = "Physics Simulation #2 - Rocks"

    default_input = self.input 
    self.input = { space: :restart, holding_left: :left, holding_right: :right }
    self.input.merge! default_input

    @background_image = Gosu::Image["fundo-demo-2.png"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]
    
    $space.damping = 0.9    
    $space.gravity = CP::Vec2.new(0.0, 1000.0)
    @dt = 1.0 / 100.0
    @substeps = 1

    @rock = Rock.create(ObjectConfig::Rock)

    @static_shapes = []
    @all_targets = []
    @shapes_to_remove = []

    @aiming = false

    screen_points = [vec2(1, -1000), vec2(1, 490), 
                     vec2(799, 490), vec2(799, -1000)] 

    for i in 0..screen_points.size-2
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => [screen_points[i], screen_points[i+1]],
        :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.5
      segment.u = 0.5
      @static_shapes << segment
      segment.add_to_space($space)
    end

    @catapult = CP::Shape.factory(CP::StaticBody.new, {:vectors => [vec2(100, 500), vec2(100,400)], 
      :thickness => 5.0})
    @catapult.collision_type = :catapult
    @static_shapes << @catapult
    @catapult.add_to_space($space)

    restart

    $space.add_collision_func(:rock, :gem) do |rock_shape, gem_shape|
      @point_sound.play
      @shapes_to_remove << gem_shape
    end 

  end

  def info
    "INFO
     Position (x, y): #{@rock.position}
     Speed (x, y):   #{@rock.body.v}
     [Space] : Restart
     [D] : Show lines
     #{@feedbackMessage}"
  end

  def update
    
    @substeps.times do
      super
      @feedbackMessage = ""

      if @aiming
        @rock.body.p = vec2(mouse_x, mouse_y)
        @rock.body.v = CP::Vec2::ZERO
      end

      @shapes_to_remove.each do |shape|
        $space.remove_shape(shape)
        $space.remove_body(shape.body)

        @all_targets.each do |object| 
          if object.shape == shape
            object.shape = nil
            object.body = nil
          end 
        end
      end

    end
  end

  def left 
    @rock.apply_impulse(-1000, 0)
  end

  def right 
    @rock.apply_impulse(1000, 0)
  end

  def draw
    # TODO Zorder
    super
    catapult_img = Gosu::Image["catapult.png"]

    if $draw_segments 
      @static_shapes.each { |segment| 
        vectorA = segment.a
        vectorB = segment.b
        $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
      } 
    else
      @background_image.draw(0, 0, 0)
      catapult_img.draw(@catapult.a.x - catapult_img.width/2.0, @catapult.a.y - catapult_img.height, 10) 
    end     

    # Otimizar usando uma lib ou reduzindo os valores    
    distance = Math::sqrt((@catapult.a.x - @rock.body.p.x)**2  + 
      (@catapult.a.y - catapult_img.height - @rock.body.p.y)**2)

    if (@aiming || distance < 50)
      $window.draw_line(@catapult.a.x, @catapult.a.y - catapult_img.height, Gosu::Color::BLUE, 
                        @rock.body.p.x, @rock.body.p.y, Gosu::Color::BLUE)
    end

  end

  def shoot
    @rock.shoot
  end
  
  def restart
    @rock.restart

    @all_targets.each do |target|
      $space.remove_shape(target.shape)
      $space.remove_body(target.body)
      target.shape = nil
      target.body = nil
    end

    $space.add_shape(@catapult)

    target_points = [vec2(300,300), vec2(330,300), vec2(360,300), 
                     vec2(315,270), vec2(345,270), vec2(330,240)]

    target_points.each do |target|
      woodstone = WoodStone.create(ObjectConfig::WoodStone)
      woodstone.body.p = target
      @all_targets << woodstone

      stone = Stone.create(ObjectConfig::Stone)
      stone.body.p.x = target.x + 300
      stone.body.p.y = target.y
      @all_targets << stone
    end
      
    for i in 0..2
      gemballstone = GemBallStone.create(ObjectConfig::GemBall)
      gemballstone.body.p = vec2(400 + rand(180), 100 + rand(300))
      @all_targets << gemballstone
      next if i%2 == 0

      gemstone = GemStone.create(ObjectConfig::Gem)
      gemstone.body.p = vec2(400 + rand(180), 100 + rand(300))
      @all_targets << gemstone
    end

    gemstone = GemStone.create(ObjectConfig::Gem)
    gemstone.body.p = vec2(620, 200)
    @all_targets << gemstone  
  end

  def button_down(id)
    super
    if id == Gosu::MsLeft && (@rock.body.p.x - mouse_x).abs < 10 && (@rock.body.p.y - mouse_y).abs < 10 
      @aiming = true
      $space.remove_shape(@catapult)
    end
  end

  def button_up(id)
    super
    if id == Gosu::MsLeft && @aiming 
      @aiming = false
      @rock.shoot(mouse_x, mouse_y, @catapult)
    end
  end

end

RocksSimulation.new(800, 600).show