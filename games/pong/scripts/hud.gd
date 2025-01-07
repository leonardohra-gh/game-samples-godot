class_name HUD
extends Node

@onready var player_score_label: Label = $PlayerScore
@onready var opponent_score_label: Label = $OpponentScore

func _ready() -> void:
	reset_score()

func reset_score() -> void:
	player_score_label.text = "0"
	opponent_score_label.text = "0"

func set_player_score(score: int) -> void:
	player_score_label.text = str(score)
	
func set_opponent_score(score: int) -> void:
	opponent_score_label.text = str(score)
