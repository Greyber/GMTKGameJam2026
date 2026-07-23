extends Node2D

var ghost_scene : PackedScene = preload("res://scenes/ghost.tscn")

const CYCLE_DURATION : float = 30.0
const PLAYER_START_POS : Vector2 = Vector2(200, 400)

var max_ghost_amount : int = 5
var time_left: float = CYCLE_DURATION
var cycle_number: int = 0

var player: CharacterBody2D = null
var ghosts: Array[CharacterBody2D] = []

var all_recordings: Array = []

# ── Nodos de UI ────────────────────────────────────────────
@onready var timer_label: Label = $UI/TimerLabel
@onready var cycle_label: Label = $UI/CycleLabel

func _ready() -> void:
	player = $Player
	_start_cycle()

func _process(delta: float) -> void:
	time_left -= delta
	_update_ui()

	if time_left <= 0.0:
		_end_cycle()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_R and event.pressed and not event.echo:
		_end_cycle()
		$Level1.reset()

func _start_cycle() -> void:
	cycle_number += 1
	time_left = CYCLE_DURATION
	player.clear_frames()
	player.position = PLAYER_START_POS
	player.start_recording()

	for i in range(all_recordings.size()):
		var ghost: CharacterBody2D = ghost_scene.instantiate()
		ghost.position = PLAYER_START_POS
		add_child(ghost)
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
