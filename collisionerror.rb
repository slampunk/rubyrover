class CollisionError < StandardError
  attr :collision_id, :position
  def initialize(collision_id, position)
    @collision_id = collision_id
    @position = position
    super("collision with rover #{@collision_id+1} detected")
  end
end
