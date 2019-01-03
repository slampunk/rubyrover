class Rover
  attr_accessor :x, :y, :orientation, :movement_history,
	        :is_collided, :is_on_plateau, :collision_with
                :failed_position

  def initialize(x, y, orientation)
    raise ArgumentError, 'x-coordinate is not an integer' unless x.is_a? Fixnum
    raise ArgumentError, 'y-coordinate is not an integer' unless y.is_a? Fixnum
    raise ArgumentError, 'Provided orientation is not a cardinal point' unless ['N','S','E','W'].include? orientation

    @x = x
    @y = y
    @orientation = orientation
    @movement_history = []

    @is_collided = false
    @is_on_plateau = true
    @collision_with = -1
    @failed_position = []
  end

  def apply_path(path)
    raise ArgumentError, 'invalid path descriptor provided' unless /[LRM]+/.match(path)
    if (@is_collided || !@is_on_plateau)
      return
    end

    path_arr = path.split(//)
    path_arr.map{|movement| getPositionAfterMovement(movement)}
  end

  def getPositionAfterMovement(movement)
    case movement
      when 'M'
        moveForward
      when 'L', 'R'
	rotate(movement)
    end
    return [@x, @y]
  end

  def moveForward
    case @orientation
      when 'N'
        @y += 1
      when 'S'
	@y -= 1
      when 'E'
	@x += 1
      when 'W'
	@x -= 1
    end
  end

  def rotate(direction)
    switch_offset = direction == 'L' ? -1 : 1
    cardinal_points = ['N', 'E', 'S', 'W']
    new_orientation_index = (cardinal_points.find_index(@orientation) + switch_offset + 4) % 4
    @orientation = cardinal_points[new_orientation_index]
  end
end
