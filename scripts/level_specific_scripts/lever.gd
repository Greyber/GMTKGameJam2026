extends Node2D
class_name Lever

signal toggled(is_on: bool)

var is_on: bool = false

func _ready() -> void:
	$InteractuableArea._on_interact.connect(interact)

func interact(_by_whom: Node2D) -> void:
	is_on = not is_on
	toggled.emit(is_on)
	$Sprite.flip_h = is_on

func reset_default(_value) -> void:
	is_on = false
	$Sprite.flip_h = false
