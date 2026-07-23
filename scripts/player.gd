extends CharacterBody2D

const SPEED := 100.0
const JUMP_VELOCITY := -350.0
const GRAVITY := 980.0

var is_recording := false
var recorded_frames: Array[Dictionary] = []

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	$AnimatedSprite2D.flip_h = _get_flip()
	

var _e_was_pressed := false
func clear_frames() -> void:
	recorded_frames = []

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Input
	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Interacción
	var has_interact : bool = false
	if Input.is_action_just_pressed("interact"):
		has_interact = true
		_perform_interaction()

	move_and_slide()
	# Grabar frame
	if is_recording:
		recorded_frames.append({
			"position": position,
			"velocity": velocity,
			"flip_h": _get_flip(),
			"interact": has_interact
		})

func _perform_interaction() -> void:
	if has_node("InteractionDetector"):
		var areas = $InteractionDetector.get_overlapping_areas()
		for area in areas:
			if area.has_method("interact"):
				area.interact(self)
				break

func start_recording() -> void:
	recorded_frames.clear()
	is_recording = true

func stop_recording() -> Array[Dictionary]:
	is_recording = false
	return recorded_frames.duplicate()

func _get_flip() -> bool:
	# Útil si el sprite tiene flip según dirección
	var dir := Input.get_axis("ui_left", "ui_right")
	if dir < 0:
		return true
	elif dir > 0:
		return false
	# Mantener último
	if has_node("AnimatedSprite2D"):
		return $AnimatedSprite2D.flip_h
	return false
