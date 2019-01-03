class Map
  attr_reader :width, :height
  attr_accessor :rover_positions

  def initialize(width, height)
    @width = width
    @height = height
    @rover_positions = []
  end

  def initialize_rover_position(position)
    @rover_positions.push(position)
  end

  def set_rover_position(rover_index, position)
    raise RangeError, "rover index out of bounds" if rover_index >= @rover_positions.length

    @rover_positions[rover_index] = position
  end
end
