class_name MoveByInput
extends MovementBehavior

func get_target_direction_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
