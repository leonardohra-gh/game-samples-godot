class_name Opponent
extends Paddle

@export var node_to_follow: Node2D
@onready var movement_node: Movement2D = $Movement

func _ready() -> void:
	movement_node.get_behavior().node_to_follow = node_to_follow
	movement_node.get_behavior().tolerance = 10
	
