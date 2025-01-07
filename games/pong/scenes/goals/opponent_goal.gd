class_name OpponentGoal
extends Area2D

signal player_scored()

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(node: Node2D) -> void:
	if node.is_in_group("ball"):
		player_scored.emit()
	
