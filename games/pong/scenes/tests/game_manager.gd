extends Node2D

@export var player_goal: PlayerGoal
@export var opponent_goal: OpponentGoal
@export var hud: HUD
@export var ball: Ball

var player_score = 0
var opponent_score = 0
var max_score = 5

func _ready() -> void:
	player_goal.opponent_scored.connect(increase_opponent_score)
	player_goal.opponent_scored.connect(ball.start)
	opponent_goal.player_scored.connect(increase_player_score)
	opponent_goal.player_scored.connect(ball.start)

func increase_player_score() -> void:
	player_score += 1
	hud.set_player_score(player_score)
	end_game_if_done(player_score)

func increase_opponent_score() -> void:
	opponent_score += 1
	hud.set_opponent_score(opponent_score)
	end_game_if_done(opponent_score)

func end_game_if_done(score: int) -> void:
	if score >= max_score:
		restart_game()

func restart_game() -> void:
	player_score = 0
	opponent_score = 0
	hud.reset_score()
	ball.start()
