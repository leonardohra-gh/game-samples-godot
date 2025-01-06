class_name Opponent
extends Paddle

@export var node_to_follow: Node2D
@onready var movement: Movement2D = $Movement

func _ready() -> void:
	movement.get_behavior().node_to_follow = node_to_follow
