extends Node2D

@export var debugging : bool = false
var max_ghosts_amount : int = 0
var cycle_duration : float = 3
var player_spawn_position : Vector2
var player_scene : PackedScene = preload("res://scenes/player.tscn")

func _ready() -> void:
	player_spawn_position = $PlayerSpawnPosition.global_position
	if debugging:
		var p = player_scene.instantiate()
		p.debugging = true
		p.position = player_spawn_position
		add_child(p)

func reset() -> void:
	for door in $AllDoors.get_children():
		door.toggle(false)
	for lever in $AllLevers.get_children():
		lever.reset_default(false)
