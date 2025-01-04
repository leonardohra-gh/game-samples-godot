extends Node2D

@export_category("General")
## Check this if player can move through X axis
@export var x_axis_allowed: bool = true
## Check this if player can move through Y axis
@export var y_axis_allowed: bool = true
## The object's speed in pixels/second
@export var speed: float = 200

@export_category("Physics")
## If the object should have momentum
@export var should_have_momentum: bool = true
## How fast the object should reach "speed"
@export_range(0, 1) var momentum_factor: float = 0.05

var parent_body: CharacterBody2D

func _ready() -> void:
	parent_body = owner as CharacterBody2D
	
	if not parent_body:
		push_error("Movement script should be attached to a CharacterBody2D!")
		
func _physics_process(_delta: float) -> void:
	move()
	
func move() -> void:
	var target_velocity = calculate_target_velocity()
	var lerp_factor = momentum_factor if should_have_momentum else 1.0
	move_parent_body(target_velocity, lerp_factor)

func calculate_target_velocity() -> Vector2:
	# Need to set up these inputs
	var allowed_axis = Vector2(x_axis_allowed, y_axis_allowed)
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target_velocity = input_vector * speed * allowed_axis
	return target_velocity
	
func move_parent_body(target_velocity: Vector2, lerp_factor: float) -> void:
	var current_velocity = parent_body.velocity
	parent_body.velocity = lerp(current_velocity, target_velocity, lerp_factor)
	parent_body.move_and_slide()
