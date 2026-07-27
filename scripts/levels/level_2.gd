extends Node2D

var max_ghosts_amount : int = 5
var cycle_duration : float = 30
var player_spawn_position : Vector2

func _ready() -> void:
	$AllLevers/Lever.on_toggled.connect(func(is_on: bool): $AllDoors/Door.toggle(is_on))
	
	$ButtonGroupManager.buttons.append($AllPressureButtons/PressureButton)
	$ButtonGroupManager.buttons.append($AllPressureButtons/PressureButton2)
	$ButtonGroupManager.set_listeners()
	$ButtonGroupManager.objective = $AllDoors/Door2
	
	player_spawn_position = $PlayerSpawnPosition.global_position

func reset() -> void:
	for door in $AllDoors.get_children():
		door.toggle(false)
	for lever in $AllLevers.get_children():
		lever.reset_default(false)
