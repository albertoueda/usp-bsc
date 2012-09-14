require 'rubygems'
require 'gosu'
require 'chipmunk'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
MAX_ANGLE = 100.0
MIN_ANGLE = 5.0
SUBSTEPS = 6

class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end

  def angle_to_vec2
    CP::Vec2.new(Math::cos(self * Math::PI / 180.0), - Math::sin(self * Math::PI / 180.0))
  end
end

module ZOrder
  Background, Alvo, Ball, Canhao, UI = *0..4
end

class Canhao
  attr_reader :shape
  attr_accessor :angulo, :armed, :fired

  def initialize(window, shape)
    @image = Gosu::Image.new(window, "media/canhao3.png", false)
    @shape = shape
    @shape.body.p = CP::Vec2.new(100.0, 300.0)
    @angulo = 45.0
    @armed = false
    @fired = false
  end
 
  def turn_up
    if @angulo < MAX_ANGLE      
      @angulo += 0.1
    else
      @feedbackMessage = "Max!"  
    end
  end
  
  def turn_down
    if @angulo > MIN_ANGLE
      @angulo -= 0.1
    else
      @feedbackMessage = "Min!"  
    end
  end
  
  def draw
    @image.draw_rot(@shape.body.p.x, @shape.body.p.y, ZOrder::Canhao, @shape.body.a.radians_to_gosu)
  end 
end

class Ball
  attr_reader :shape, :img
  
  def initialize(window, shape)    
    @img = Gosu::Image.new(window, "media/cannonball2.png", true)
    @shape = shape
    @shape.body.p = CP::Vec2.new(140, 100)
    @shape.body.v = CP::Vec2.new(0.0, 0.0)
    # @shape.body.a = (3*Math::PI/2.0)
  end

  def validate_position
    if (@shape.body.p.x > SCREEN_WIDTH || @shape.body.p.x < 0 || @shape.body.p.y > SCREEN_HEIGHT)
      @shape.body.p = CP::Vec2.new(140.0, 200.0)
      @shape.body.v = CP::Vec2.new(0.0, 0.0)
      return true
    end

    return false
  end

  def draw      
    @img.draw(@shape.body.p.x - img.width / 2.0, @shape.body.p.y - img.height / 2.0, ZOrder::Ball)
  end
end

class Target
  attr_reader :shape

  def initialize(window, shape)
    @alvo_image = Gosu::Image.new(window, "media/target2.png", true)
    @shape = shape 
    @shape.body.p = CP::Vec2.new(500 + rand(250), 100 + rand(300))
  end

  def draw  
    @alvo_image.draw(@shape.body.p.x, @shape.body.p.y, ZOrder::Alvo)  
  end
end

class GameWindow < Gosu::Window

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false, 16)
    self.caption = "TCC Demo 1 - Alberto e Issao"

    @background_image = Gosu::Image.new(self, "media/fundo-demo-1.png", true)    
    @fire_sound= Gosu::Sample.new(self, "media/explosion.wav")   
    @point_sound= Gosu::Sample.new(self, "media/Beep.wav")   
    @score = 0    
    @wind_force = -1500 + rand(2500)
    @path_points = []

    # ?
    @steps = 0;

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @dt = 1.0/60.0    
    
    @space = CP::Space.new
    @space.damping = 0.8    
    @space.gravity = CP::Vec2.new(0.0, 50.0)

    body = CP::Body.new(100, 15000)
    shape_array = [CP::Vec2.new(-50.0, -14.0), CP::Vec2.new(-50.0, 14.0), CP::Vec2.new(50.0, 14.0), CP::Vec2.new(50.0, -14.0)]
    shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
    shape.collision_type = :canhao
    @canhao = Canhao.new(self, shape)
    @space.add_shape(shape)
    @space.add_body(body)
        
    targetBody = CP::StaticBody.new    
    targetShape = CP::Shape::Circle.new(targetBody, 20, CP::Vec2.new(50/2, 75/2))
    targetShape.collision_type = :target
    targetShape.e = 0.8
    # CP::DebugDraw.BB(targetShape.bb, 0xff00ffff)
    @target = Target.new(self, targetShape)
    @space.add_shape(targetShape)

    segmentBody = CP::StaticBody.new()
    vectorA = CP::Vec2.new(90.0, 480.0)
    vectorB = CP::Vec2.new(120.0, 480.0)
    segmentShape = CP::Shape::Segment.new(segmentBody, vectorA, vectorB, 0.1)
    @space.add_shape(segmentShape)     

    # GB : Para parar o canhao de ir pra frente
    segmentBody = CP::StaticBody.new()
    vectorA = CP::Vec2.new(150.0, 470.0)
    vectorB = CP::Vec2.new(150.0, 480.0)
    segmentShape = CP::Shape::Segment.new(segmentBody, vectorA, vectorB, 0.1)
    @space.add_shape(segmentShape)     

    body2 = CP::Body.new(0.1, 0.0001)
    shape2 = CP::Shape::Circle.new(body2, 25/2, CP::Vec2.new(0.0, 0.0))
    shape2.collision_type = :ball    
    shape2.e = 0.8
    @space.add_shape(shape2)
    @space.add_body(body2)
    @ball = Ball.new(self, shape2)

    @space.add_collision_func(:canhao, :ball) do |cannon_shape, ball_shape| 
      @canhao.armed = true    
      # @ball.shape.body.v = CP::Vec2.new(0.0, 0.0)      
    end

    @space.add_collision_func(:target, :ball) do |target_shape, ball_shape| 
      @canhao.fired = false
      @point_sound.play         
      @score += 20
    end    
  end

  def update
   SUBSTEPS.times do
      @canhao.shape.body.reset_forces
      @ball.shape.body.reset_forces
      
      unless @canhao.armed or @canhao.fired == false
        @ball.shape.body.apply_force(CP::Vec2.new(1.0, 0.0) * @wind_force/1000, CP::Vec2.new(0.0, 0.0))
        @steps += 1
       end 

      if @canhao.fired and @steps % 5 == 0
        @path_points << CP::Vec2.new(@ball.shape.body.p.x, @ball.shape.body.p.y)
      end

      if @ball.validate_position   
         @space.remove_shape(@target.shape)
         @target.shape.body.p = CP::Vec2.new(500 + rand(250), 100 + rand(300))
         @space.add_shape(@target.shape)
         @canhao.fired = false
         @wind_force = -1500 + rand(2500)         
      end

      @feedbackMessage = ""  

      if (@canhao.armed)
        @feedbackMessage = "Armed."      
      end

      if button_down? Gosu::KbUp
        @canhao.turn_up
      end
      if button_down? Gosu::KbDown
        @canhao.turn_down
      end
      
      if button_down? Gosu::KbSpace        
        if @canhao.armed
          @fire_sound.play          
          @ball.shape.body.apply_force(@canhao.angulo.angle_to_vec2 * 1000.0, CP::Vec2.new(0.0, 0.0))
          @canhao.armed = false
          @canhao.fired = true
          @path_points.clear
          @steps = 0
        elsif @ball.shape.body.v.y > - 10.0
          @feedbackMessage = "Wait!"
        end
      end
      
      @space.step(@dt)
    end    
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @canhao.draw
    @ball.draw
    @target.draw
    @font.draw("Score: #{@score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Cannon (Θ): #{@canhao.angulo}º", 10, 30, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Vec2: #{@canhao.angulo.angle_to_vec2}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("#{@feedbackMessage}", 10, 70, ZOrder::UI, 1.0, 1.0, 0xffffff00)    
    @font.draw("Wind: #{@wind_force/10.0} kM/h", 500, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Steps: #{@steps}", 500, 30, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Cannon (x, y): #{@canhao.shape.body.p}", 500, 50, ZOrder::UI, 1.0, 1.0, 0xffffff00)

    @path_points.each do |path_point| 
      @font.draw("'", path_point.x, path_point.y, ZOrder::Background, 1.0, 1.0, 0xffffffff)
    end
    
  end

  def button_down(id)
    if id == Gosu::KbEscape then
      close
    end
  end

  def needs_cursor?   
    true
  end 
end

window = GameWindow.new
window.show