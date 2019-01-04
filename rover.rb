class Rover
  attr_accessor :x, :y, :orientation,:is_collided, :is_on_plateau, :collision_with
                :failed_position

  def initialize(x, y, orientation)
    @x = x.to_i
    @y = y.to_i
    @orientation = orientation
    @movement_history = []

    @is_collided = false
    @is_on_plateau = true
    @collision_with = -1
    @failed_position = {'x' => -1, 'y' => -1}

    @take_step = {
      'N' => [0, 1],
      'S' => [0, -1],
      'E' => [1, 0],
      'W' => [-1, 0],
    }
  end

  def getResult
    collision_text = " collided with rover #{collision_with}"
    return "#{@x} #{@y} #{@orientation}#{@is_collided ? collision_text : ''}#{!@is_on_plateau ? 'rover fell off plateau' : ''}"
  end

  def setPosition(pos)
    @x = pos['x']
    @y = pos['y']
  end

  def followPath(movement)
    case movement
      when 'M'
        move
      when 'L', 'R'
	      rotate(movement)
    end
    return {'x' => @x, 'y' => @y}
  end

  private

  def move
    @x += @take_step[@orientation][0]
    @y += @take_step[@orientation][1]
  end

  def rotate(direction)
    if (direction == 'L')
      rotateLeft
    else
      rotateRight
    end
  end

  def rotateRight()
    rotations = {
      "N" => "E",
      "E" => "S",
      "S" => "W",
      "W" => "N"
    }
    @orientation = rotations[@orientation]
  end

  def rotateLeft()
    rotations = {
      "N" => "W",
      "W" => "S",
      "S" => "E",
      "E" => "N"
    }
    @orientation = rotations[@orientation]
  end

end
