extends Node2D

@export var debugging : bool = false
var max_ghosts_amount : int = 4
var cycle_duration : float = 25
var player_spawn_position : Vector2
var player_scene : PackedScene = preload("res://scenes/player.tscn")

func _ready() -> void:
	player_spawn_position = $PlayerSpawnPosition.global_position
	$AllLevers/Lever.on_toggled.connect(func(is_on: bool): $AllDoors/Door.toggle(is_on))
	$AllLevers/Lever.on_toggled.connect(func(is_on: bool): $AllDoors/Door2.toggle(is_on))

func reset() -> void:
	for door in $AllDoors.get_children():
		door.toggle(false)
	for lever in $AllLevers.get_children():
		lever.reset_default(false)
