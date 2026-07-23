extends Node2D
class_name Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func toggle(_value: bool) -> void:
	visible = not _value
	$HitBox/CollisionShape2D.set_deferred("disabled", _value)
