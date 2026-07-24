extends Node2D

var ghost_scene : PackedScene = preload("res://scenes/ghost.tscn")

var player_spawn_position : Vector2 = Vector2(200, 400)
var cycle_duration : float = 30.0
var max_ghost_amount : int = 5
var time_left: float = cycle_duration
var cycle_number: int = 0
var current_level_index : int = 0
var running : bool = false
var on_menu = false

var ghosts: Array[CharacterBody2D] = []
var all_recordings: Array = []

@onready var camera : Camera2D = $MainCamera
@onready var player : Player = $Player
@onready var timer_label: Label = $GameUI/TimerLabel
@onready var cycle_label: Label = $GameUI/CycleLabel

func _ready() -> void:
	player.can_move = false
	_set_current_level_values()
	_start_cycle()
	EventBus.ON_LOAD_NEXT_LEVEL.connect(_start_loading_next_level)
	EventBus.ON_START_NEXT_LEVEL.connect(_start_next_level)

func _process(delta: float) -> void:
	if on_menu:
		pass
	else: 
		_update_ui()
		if not running: return
		time_left -= delta

		if time_left <= 0.0:
			_end_cycle()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_R and event.pressed and not event.echo:
		_reset_cycle()

func _start_cycle() -> void:
	cycle_number += 1
	time_left = cycle_duration
	player.clear_frames()
	player.start_recording()

	for i in range(all_recordings.size()):
		var ghost: CharacterBody2D = ghost_scene.instantiate()
		ghost.position = player_spawn_position
		$AllGhosts.add_child(ghost)
		ghost.start_playback(all_recordings[i])
		ghosts.append(ghost)

func _end_cycle() -> void:
	if ghosts.size() >= max_ghost_amount: 
		_start_cycle()
		return
	var recording: Array[Dictionary] = player.stop_recording()
	all_recordings.append(recording)

	for ghost in ghosts:
		ghost.queue_free()
	ghosts.clear()

	_start_cycle()

func _update_ui() -> void:
	var secs: int = int(ceil(time_left))
	timer_label.text = "Tiempo: %d" % secs
	cycle_label.text  = "Ciclo: %d  |  Fantasmas Restantes: %d" % [cycle_number, max_ghost_amount - ghosts.size()]

func _reset_cycle() -> void:
	player.position = to_global(player_spawn_position)
	_end_cycle()
	$Levels.get_children()[current_level_index].reset()

func _set_current_level_values() -> void:
	var level : Node2D = $Levels.get_children()[current_level_index]
	max_ghost_amount = level.max_ghosts_amount
	cycle_duration = level.cycle_duration
	player_spawn_position = level.player_spawn_position

func _start_loading_next_level() -> void:
	running = false
	camera.set_loading_next_level_state()
	player.can_move = false

func _start_next_level() -> void:
	running = true
	current_level_index += 1
	all_recordings = []
	for ghost in $AllGhosts.get_children():
		ghost.queue_free()
	player.can_move = true
	_set_current_level_values()
	_start_cycle()
	camera.set_normal_state()
