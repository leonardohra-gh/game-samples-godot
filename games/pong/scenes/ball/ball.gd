class_name Ball
extends RigidBody2D

@export var initial_speed: float = 400
@export var max_speed: float = 1000

@onready var speed: float = initial_speed
@onready var initial_position: Vector2 = position

# The angles below are to respect to Vector2.RIGHT
const DEGREE_45 = PI/4
const DEGREE_90 = PI/2
const DEGREE_135 = 3*PI/4
const DEGREE_180 = PI
const DEGREE_225 = -DEGREE_135
const DEGREE_270 = -DEGREE_90
const DEGREE_315 = -DEGREE_45

func _ready() -> void:
	connect("body_exited", _on_body_exited)
	start()

func start() -> void:
	sleeping = true
	global_transform.origin = initial_position
	sleeping = false
	speed = initial_speed
	var direction = generate_random_direction()
	linear_velocity = direction * speed

func generate_random_direction() -> Vector2:
	var angle_chosen = randf_range(0, 2*PI)
	var corrected_angle = correct_angle(angle_chosen)
	return Vector2.RIGHT.rotated(corrected_angle)

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = linear_velocity.normalized() * speed
	pass

func _on_body_exited(node: Node2D) -> void:
	if node.is_in_group("paddle"):
		adjust_speed()
		adjust_paddle_position(node)
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
	
func adjust_speed() -> void:
	speed *= 1.1
	if speed > max_speed: speed = max_speed

func adjust_paddle_position(node: Node2D) -> void:
	var paddle: Paddle = node as Paddle
	paddle.reset_x()
	
