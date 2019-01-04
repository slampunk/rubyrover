class SuicideError < StandardError
  attr :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    super("rover fell off the plateau at position (#{@x}, #{@y})")
  end
end
