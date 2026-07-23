extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		var areas : Array[Node2D] = $MovablePlatform/InteractArea.get_overlapping_bodies()
		if areas: 
			$MovablePlatform.speed = Vector2(0, -30)
