extends Node2D

var max_ghosts_amount : int = 4
var cycle_duration : float = 30
var player_spawn_position : Vector2

func _ready() -> void:
	player_spawn_position = $PlayerSpawnPosition.global_position

func reset() -> void:
	pass
