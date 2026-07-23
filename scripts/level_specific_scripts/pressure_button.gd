extends Area2D
class_name PressureButton

signal button_pressed
signal button_released

const ZONE_H   := 56.0
const PLATE_W  := 64.0
const PLATE_H  := 10.0

# ── Estado ────────────────────────────────────────────────────
var bodies_inside: int = 0
var is_pressed: bool   = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(_body: Node2D) -> void:
	bodies_inside += 1
	if not is_pressed:
		$Panel.offset_top = 22
		is_pressed = true
		button_pressed.emit()

func _on_body_exited(_body: Node2D) -> void:
	bodies_inside = max(0, bodies_inside - 1)
	if bodies_inside == 0 and is_pressed:
		$Panel.offset_top = 16
		is_pressed = false
		button_released.emit()
