extends Node

@export var buttons: Array = []
@export var objective : Node2D
var action_type : Global.ACTIONS_TYPE

func _ready() -> void:
	pass

func set_listeners() -> void:
	for button in buttons:
		button.button_pressed.connect(_on_button_pressed)
		button.button_released.connect(_on_button_released)
	check_buttons()
	
func _on_button_pressed() -> void:
	check_buttons()

func _on_button_released() -> void:
	check_buttons()

func check_buttons() -> void:
	if not objective: return
	var all_pressed: bool = true
	for button in buttons:
		if not button.is_pressed:
			all_pressed = false
			break
	print(all_pressed)
	execute_action(all_pressed)
	
func execute_action(active: bool):
	ActionsManager.execute_action(action_type, [objective], [active])
