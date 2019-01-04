require './collisionerror.rb'
require './suicideerror.rb'

class Map
  attr_reader :x_range, :y_range

  def initialize(args)
    @rover_positions = []
    startX = (args['startX'] || 0).to_i
    startY = (args['startY'] || 0).to_i
    widthX = (args['width'] || 0).to_i
    widthY = (args['height'] || 0).to_i

    if (startX == 0 && startY == 0 && widthX == 0 && widthY == 0)
      @x_range=-Float::Infinity..Float::Infinity
      @y_range=-Float::Infinity..Float::Infinity
    else
      @x_range=[startX, widthX].min..[startX, widthX].max
      @y_range=[startY, widthY].min..[startY, widthY].max
    end
  end

  def initialize_rover_position(position)
    @rover_positions.push(position)
  end

  def set_rover_position(rover_index, position)
    raise RangeError, "rover index out of bounds" if rover_index >= @rover_positions.length

    if (!@x_range.include?(position['x']) || !@y_range.include?(position['y']))
      raise SuicideError.new(position['x'], position['y'])
    end

    @rover_positions.each.with_index {|roverPos, index|
      if (index != rover_index && roverPos['x'] == position['x'] && roverPos['y'] == position['y'])
        raise CollisionError.new(index, position)
      end
    }

    @rover_positions[rover_index] = {
      'x' => position['x'],
      'y' => position['y']
    }
  end
end
