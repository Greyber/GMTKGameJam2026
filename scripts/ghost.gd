extends CharacterBody2D

var playback_frames: Array[Dictionary] = []
var current_frame: int = 0
var is_playing := false


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$InteractuableArea._on_interact.connect(func(by_whon): print('hola'))
	
func _physics_process(_delta: float) -> void:
	if not is_playing:
		return

	if current_frame >= playback_frames.size():
		# Se acabó el ciclo grabado, quedarse quieto en la última posición
		set_physics_process(false)
		return

	var frame_data: Dictionary = playback_frames[current_frame]

	# Restaurar posición grabada directamente.
	# Como el fantasma NO colisiona con el jugador ni con otros fantasmas,
	# este teleporte no genera fuerzas de empuje extrañas.
	global_position = frame_data["position"]
	velocity = frame_data["velocity"]

	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.flip_h = frame_data["flip_h"]
	elif has_node("Sprite2D"):
		$Sprite2D.flip_h = frame_data["flip_h"]

	if frame_data.get("interact", false):
		_perform_interaction()
	current_frame += 1

func _perform_interaction() -> void:
	var areas :Array[Area2D] = $InteractuableArea.get_overlapping_areas()
	for area in areas:
		area._on_interact.emit(self)

func start_playback(frames: Array[Dictionary]) -> void:
	playback_frames = frames.duplicate()
	current_frame = 0
	is_playing = true
	set_physics_process(true)
	modulate = Color(0.5, 0.8, 1.0, 0.55)  # Tinte fantasmal semitransparente

func stop_playback() -> void:
	is_playing = false
	set_physics_process(false)
