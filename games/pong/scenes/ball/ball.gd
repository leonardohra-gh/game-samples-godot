extends RigidBody2D

@export var speed: float = 200
@export var max_speed: float = 1000

# The angles below are to respect to Vector2.RIGHT
const DEGREE_45 = PI/4
const DEGREE_90 = PI/2
const DEGREE_135 = 3*PI/4
const DEGREE_180 = PI
const DEGREE_225 = -DEGREE_135
const DEGREE_270 = -DEGREE_90
const DEGREE_315 = -DEGREE_45
# from 135º to 225º, 
const angle_range_left = [DEGREE_135, DEGREE_225] 
#from -45º to 45º
const angle_range_right = [DEGREE_315, DEGREE_45]
	
func _ready() -> void:
	var direction = generate_random_direction()
	linear_velocity = direction * speed
	connect("body_exited", _on_body_exited)
	
func generate_random_direction() -> Vector2:
	var angle_ranges = [angle_range_left, angle_range_right]
	var direction = randi_range(0, 1)
	var angle_range_for_direction = angle_ranges[direction]
	var angle_chosen = randf_range(angle_range_for_direction[0], angle_range_for_direction[1])
	return Vector2.RIGHT.rotated(angle_chosen)

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = linear_velocity.normalized() * speed

func _on_body_exited(body: PhysicsBody2D) -> void:
	if body.is_in_group("paddle"):
		speed *= 1.1
		if speed > max_speed: speed = max_speed
		redirect_ball()
		
func redirect_ball():
	var current_direction = linear_velocity.normalized()
	var current_angle = current_direction.angle()
	var corrected_angle = correct_angle(current_angle)
	var direction = Vector2.RIGHT.rotated(corrected_angle)
	linear_velocity = direction * speed

func correct_angle(angle: float) -> float:
	if angle > DEGREE_45 and angle < DEGREE_90: return DEGREE_45
	else: if angle > DEGREE_90 and angle < DEGREE_135: return DEGREE_135 
	else: if angle > DEGREE_225 and angle < DEGREE_270: return DEGREE_225 
	else: if angle > DEGREE_270 and angle < DEGREE_315: return DEGREE_315 
	return angle
