#!/bin/env ruby
# encoding: utf-8

require_relative 'config/config'
require_relative 'lib/physics'


class Rock < PhysicObject
  attr_accessor :engaged
  
  def setup
    super
    # self.input = {:holding_right => :move_right, :holding_left => :move_left, 
      # :holding_up => :move_up, :holding_down => :move_down}

    @image = Gosu::Image["cannonball2.png"]
    @engaged = true
  end

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
    k = 25
    apply_impulse(k/2.0*(center_x-x)*(x-center_x).abs, k/2.0*(center_y-y)*(y-center_y).abs)
  end

  # def shoot
  #   apply_impulse(20000, -15000 - rand(10000))
  # end
end

class Stone < PhysicObject

  def setup
    super
    @image = Gosu::Image["stone.png"]
  end
end

class WoodStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["woodstone.png"]
  end
end

class GemStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["gem.png"]
  end
end

class GemBallStone < PhysicObject

  def setup
    super
    @image = Gosu::Image["gem-ball.png"]
  end
end

class RocksSimulation < PhysicWindow

  def setup
    self.caption = "TCC Demo 2 - Rocks"
    self.input = {esc: :exit, space: :shoot, r: :restart, d: :toggle_lines, holding_left: :left, holding_right: :right }

    @background_image = Gosu::Image["fundo-demo-2.png"]
    @fire_sound= Gosu::Sample["explosion.wav"]
    @point_sound= Gosu::Sample["Beep.wav"]
    @info_area = Chingu::Text.create("", :x => 300, :color => Gosu::Color::YELLOW)    

    $space.damping = 0.9    
    $space.gravity = CP::Vec2.new(0.0, 150.0)

    @rock = Rock.create(ObjectConfig::Rock)

    @segment_shapes = []
    @all_target_shapes = []
    @shapes_to_remove = []

    @draw_segments = false
    @aiming = false

    screen_points = [vec2(0, -1000), vec2(0, 490), 
                     vec2(800, 490), vec2(800, -1000)] 

    for i in 0..screen_points.size-2
      segment = CP::Shape.factory(CP::StaticBody.new, {:vectors => [screen_points[i], screen_points[i+1]],
        :thickness => 1})
      segment.collision_type = :screen
      segment.e = 0.5
      segment.u = 0.5
      @segment_shapes << segment
      segment.add_to_space($space)
    end

    @catapult = CP::Shape.factory(CP::StaticBody.new, {:vectors => [vec2(100, 500), vec2(100,400)], 
      :thickness => 5.0})
    @catapult.collision_type = :catapult
    @segment_shapes << @catapult
    @catapult.add_to_space($space)

    # spring = CP::Constraint::DampedSpring.new(@rock.body, @catapult.body, 
    #   @rock.body.p, vec2(@catapult.body.p.x, @catapult.body.p.y - 60), 0.1, 40.0, 0.0)
    # $space.add_constraint(spring)

    restart

    # $space.add_post_step_callback(
    #   :keyxx, 
    #   "do |space, key| puts('bla') end"
    # )

    $space.add_collision_func(:rock, :gem) do |rock_shape, gem_shape|
      @point_sound.play
      @shapes_to_remove << gem_shape
    end 

  end

  def info
    "INFO
     Position (x, y): #{@rock.position}
     Speed (x, y):   #{@rock.body.v}
     #{@feedbackMessage}"
  end

  def update
    super
    @info_area.text = info
    @feedbackMessage = ""  

    if (@rock.engaged)
      @feedbackMessage = "Pressione [r], [d]"
    else
      restart
    end

    if @aiming
      @rock.body.p = vec2(mouse_x, mouse_y)
      @rock.body.v = CP::Vec2::ZERO
    end

    @shapes_to_remove.each do |shape|
      $space.remove_shape(shape)
      $space.remove_body(shape.body)
    end

  end

  def left 
    @rock.apply_impulse(-1000, 0)
  end

  def right 
    @rock.apply_impulse(1000, 0)
  end

  def draw
    super
    @background_image.draw(0, 0, 0)
    # TODO Zorder

      if @draw_segments 
        @segment_shapes.each { |segment| 
          vectorA = segment.a
          vectorB = segment.b
          $window.draw_line(vectorA.x, vectorA.y, Gosu::Color::BLUE, vectorB.x, vectorB.y, Gosu::Color::BLUE)
        } 
      end     

    catapult_img = Gosu::Image["catapult.png"]
    catapult_img.draw(@catapult.a.x - catapult_img.width/2.0, @catapult.a.y - catapult_img.height, 10) 

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

    @all_target_shapes.each do |target|
      target.visible = false
      $space.remove_shape(target.shape)
      $space.remove_body(target.body)
    end
    @all_target_shapes.clear

    $space.add_shape(@catapult)

    target_points = [vec2(300,200), vec2(330,200), vec2(360,200), 
                     vec2(315,170), vec2(345,170), vec2(330,140)]

    target_points.each do |target|
      woodstone = WoodStone.create(ObjectConfig::WoodStone)
      woodstone.body.p = target
      @all_target_shapes << woodstone

      stone = Stone.create(ObjectConfig::Stone)
      stone.body.p.x = target.x + 300
      stone.body.p.y = target.y
      @all_target_shapes << stone
    end
      
    for i in 0..2
      gemballstone = GemBallStone.create(ObjectConfig::GemBall)
      gemballstone.body.p = vec2(380 + rand(200), 100 + rand(300))
      @all_target_shapes << gemballstone
      next if i%2 == 0

      gemstone = GemStone.create(ObjectConfig::Gem)
      gemstone.body.p = vec2(380 + rand(200), 100 + rand(300))
      @all_target_shapes << gemstone
    end

    gemstone = GemStone.create(ObjectConfig::Gem)
    gemstone.body.p = vec2(630, 100)
  end

  def button_down(id)
    super
    if id == Gosu::MsLeft && (@rock.body.p.x - mouse_x).abs < 10 && (@rock.body.p.y - mouse_y).abs < 10 
      @aiming = true    # TODO Como pegar o shape a partir do body?
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


  def toggle_lines
    @draw_segments = !@draw_segments  
  end

  def needs_cursor?   
    true
  end 

end

RocksSimulation.new(800, 600).show