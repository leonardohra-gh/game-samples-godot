class_name FollowNode
extends MovementBehavior

@export var node_to_follow: Node2D
## Tolerance of distance (in pixels) to the node to follow
@export var tolerance: float = 0

var parent_movement: Movement2D
var body_to_be_moved: CharacterBody2D
var axis_allowed: Vector2
	

func get_target_direction_vector() -> Vector2:
	if node_to_follow:
		var node_to_follow_position_allowed = node_to_follow.global_position * axis_allowed
		var body_to_be_moved_position_allowed = body_to_be_moved.global_position * axis_allowed
		var direction_to_node = node_to_follow_position_allowed - body_to_be_moved_position_allowed
		var distance = direction_to_node.length()
		if distance > tolerance:
			var direction_normalized = direction_to_node.normalized()
			return direction_normalized
		
	return Vector2.ZERO
	
	
func set_up() -> void:
	set_up_parent()
	set_up_body_to_be_moved()
	set_up_axis_allowed()
	
func set_up_parent() -> void:
	parent_movement = get_parent() as Movement2D
	if not parent_movement:
		push_error("Behavior script should be attached to a Movement2D!")
		
func set_up_body_to_be_moved() -> void:
	body_to_be_moved = parent_movement.get_body_to_be_moved()
	if not body_to_be_moved:
		push_error("Behavior script should have a body to be moved!")
		
func set_up_axis_allowed() -> void:
	var x_axis_allowed = parent_movement.get_x_axis_allowed()
	var y_axis_allowed = parent_movement.get_y_axis_allowed()
	axis_allowed = Vector2(x_axis_allowed, y_axis_allowed)
	
