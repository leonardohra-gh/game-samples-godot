class_name Movement2D
extends Node

@export_category("General")
## Check this if player can move through X axis
@export var x_axis_allowed: bool = true
## Check this if player can move through Y axis
@export var y_axis_allowed: bool = true
## The object's speed in pixels/second
@export var speed: float = 200
@export var behavior: MovementBehavior

@export_category("Physics")
## If the object should have momentum
@export var should_have_momentum: bool = true
## How fast the object should reach "speed"
@export_range(0, 1) var momentum_factor: float = 0.05

@onready var movement_behavior: MovementBehavior = $Behavior
var body_to_be_moved: CharacterBody2D

func _ready() -> void:
	body_to_be_moved = get_parent() as CharacterBody2D
	
	if not body_to_be_moved:
		push_error("Movement script should be attached to a CharacterBody2D!")
		return
		
	if not behavior:
		push_error("No behavior assigned to Movement2D!")
		return
	
	behavior.set_up()
		
func _physics_process(_delta: float) -> void:
	move()
	
func move() -> void:
	if not behavior: return
	var target_velocity = calculate_target_velocity()
	var lerp_factor = momentum_factor if should_have_momentum else 1.0
	move_parent_body(target_velocity, lerp_factor)

func calculate_target_velocity() -> Vector2:
	# Need to set up these inputs
	var allowed_axis = Vector2(x_axis_allowed, y_axis_allowed)
	var input_vector = behavior.get_target_direction_vector()
	var target_velocity = input_vector * speed * allowed_axis
	return target_velocity
	
func move_parent_body(target_velocity: Vector2, lerp_factor: float) -> void:
	var current_velocity = body_to_be_moved.velocity
	body_to_be_moved.velocity = lerp(current_velocity, target_velocity, lerp_factor)
	body_to_be_moved.move_and_slide()

func get_behavior() -> MovementBehavior:
	return movement_behavior

func get_body_to_be_moved() -> CharacterBody2D:
	return body_to_be_moved
	
func get_x_axis_allowed() -> bool:
	return x_axis_allowed

func get_y_axis_allowed() -> bool:
	return y_axis_allowed
	
