extends CharacterBody2D
class_name Player

const SPEED := 100.0
const JUMP_VELOCITY := -350.0
const GRAVITY := 980.0

var can_move : bool = true
var is_recording := false
var recorded_frames: Array[Dictionary] = []

func _ready() -> void:
	$AnimatedSprite2D.play("walking")

func _process(delta: float) -> void:
	$AnimatedSprite2D.flip_h = _get_flip(velocity.x)
	

var _e_was_pressed := false
func clear_frames() -> void:
	recorded_frames = []

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Input
	var has_interact : bool = false
	var dir : float
	if can_move:
		dir = Input.get_axis("ui_left", "ui_right")
		velocity.x = dir * SPEED

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Interacción
		if Input.is_action_just_pressed("interact"):
			has_interact = true
			_perform_interaction()
		if dir == 0: 
			$AnimatedSprite2D.play("idle")

	move_and_slide()
		
	if is_recording:
		recorded_frames.append({
			"position": position,
			"velocity": velocity,
			"flip_h": _get_flip(dir),
			"interact": has_interact
		})

func _perform_interaction() -> void:
	var areas :Array[Area2D] = $InteractuableArea.get_overlapping_areas()
	for area in areas:
		area._on_interact.emit(self)

func start_recording() -> void:
	recorded_frames.clear()
	is_recording = true

func stop_recording() -> Array[Dictionary]:
	is_recording = false
	return recorded_frames.duplicate()

func _get_flip(_dir) -> bool:
	if _dir < 0:
		return true
	elif _dir > 0:
		return false
	# Mantener último
	if has_node("AnimatedSprite2D"):
		return $AnimatedSprite2D.flip_h
	return false
