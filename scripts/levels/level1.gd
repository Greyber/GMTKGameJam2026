extends Node2D

var max_ghosts_amount : int = 3
var cycle_duration : float = 15
var player_spawn_position : Vector2

func _ready() -> void:
	player_spawn_position = $PlayerSpawnPosition.position
	$AllLevers/Lever.on_toggled.connect(func(is_on: bool): $AllDoors/Door2.toggle(is_on))
	$AllLevers/Lever2.on_toggled.connect(func(is_on: bool): $AllDoors/Door.toggle(is_on))
	
	$ButtonGroupManager1.buttons.append($AllPressureButtons/PressureButton)
	$ButtonGroupManager1.buttons.append($AllPressureButtons/PressureButton2)
	$ButtonGroupManager1.set_listeners()
	$ButtonGroupManager1.objective = $AllDoors/Door1
	

func reset() -> void:
	for door in $AllDoors.get_children():
		door.toggle(false)
	for lever in $AllLevers.get_children():
		lever.reset_default(false)
