class_name Paddle
extends CharacterBody2D

@onready var initial_x = position.x

func reset_x() -> void:
	position.x = initial_x
