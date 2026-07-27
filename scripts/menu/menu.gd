extends Control

var is_settings_open : bool = false
var is_transitioning : bool = false
var original_settings_pos : Vector2
var settings_tween : Tween
var start_button_hover_tween : Tween
var settings_button_hover_tween : Tween
var credits_button_hover_tween : Tween
var lenguages : Array = ["en", "es"]
var current_lenguage = lenguages[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_settings_pos = $VolumeSettings.position
	
	# Set pivot offsets to center for scaling animations
	$StartButton.pivot_offset = $StartButton.size / 2
	$SettingsButton.pivot_offset = $SettingsButton.size / 2
	
	# Connect hover signals for the buttons
	$StartButton.mouse_entered.connect(_on_start_button_mouse_entered)
	$StartButton.mouse_exited.connect(_on_start_button_mouse_exited)
	$SettingsButton.mouse_entered.connect(_on_settings_button_mouse_entered)
	$SettingsButton.mouse_exited.connect(_on_settings_button_mouse_exited)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_settings_open and not is_transitioning:
			var panel_rect = $VolumeSettings.get_global_rect()
			if not panel_rect.has_point(event.global_position):
				close_settings()


func open_settings() -> void:
	if is_settings_open or is_transitioning:
		return
	is_settings_open = true
	is_transitioning = true
	
	if start_button_hover_tween:
		start_button_hover_tween.kill()
	if settings_button_hover_tween:
		settings_button_hover_tween.kill()
	if credits_button_hover_tween:
		credits_button_hover_tween.kill()
	if settings_tween:
		settings_tween.kill()
		
	settings_tween = create_tween()
	settings_tween.set_parallel(true)
	settings_tween.set_trans(Tween.TRANS_SINE)
	settings_tween.set_ease(Tween.EASE_IN_OUT)
	
	settings_tween.tween_property($StartButton, "scale", Vector2.ZERO, 0.2)
	settings_tween.tween_property($StartButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($SettingsButton, "scale", Vector2.ZERO, 0.2)
	settings_tween.tween_property($SettingsButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($CreditsButton, "scale", Vector2.ZERO, 0.1)
	settings_tween.tween_property($CreditsButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($VolumeSettings, "position", Vector2(340, 175), 0.25)
	
	settings_tween.chain().tween_callback(func():
		$StartButton.visible = false
		$SettingsButton.visible = false
		$CreditsButton.visible = false
		
		is_transitioning = false
	)


func close_settings() -> void:
	if not is_settings_open or is_transitioning:
		return
	is_settings_open = false
	is_transitioning = true
	
	if settings_tween:
		settings_tween.kill()
		
	$StartButton.visible = true
	$SettingsButton.visible = true
	$CreditsButton.visible = true
	
	
	settings_tween = create_tween()
	settings_tween.set_parallel(true)
	settings_tween.set_trans(Tween.TRANS_SINE)
	settings_tween.set_ease(Tween.EASE_IN_OUT)
	
	settings_tween.tween_property($StartButton, "scale", Vector2.ONE, 0.2)
	settings_tween.tween_property($StartButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($SettingsButton, "scale", Vector2.ONE, 0.2)
	settings_tween.tween_property($SettingsButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($CreditsButton, "scale", Vector2.ONE, 0.2)
	settings_tween.tween_property($CreditsButton, "rotation_degrees", 0.0, 0.2)
	settings_tween.tween_property($VolumeSettings, "position", original_settings_pos, 0.25)
	
	settings_tween.chain().tween_callback(func():
		is_transitioning = false
	)


func _on_start_button_mouse_entered() -> void:
	if is_settings_open or is_transitioning:
		return
	if start_button_hover_tween:
		start_button_hover_tween.kill()
	start_button_hover_tween = create_tween()
	start_button_hover_tween.set_parallel(true)
	start_button_hover_tween.set_trans(Tween.TRANS_SINE)
	start_button_hover_tween.set_ease(Tween.EASE_OUT)
	start_button_hover_tween.tween_property($StartButton, "scale", Vector2(1.05, 1.05), 0.15)
	start_button_hover_tween.tween_property($StartButton, "rotation_degrees", 2.0, 0.15)


func _on_start_button_mouse_exited() -> void:
	if is_settings_open or is_transitioning:
		return
	if start_button_hover_tween:
		start_button_hover_tween.kill()
	start_button_hover_tween = create_tween()
	start_button_hover_tween.set_parallel(true)
	start_button_hover_tween.set_trans(Tween.TRANS_SINE)
	start_button_hover_tween.set_ease(Tween.EASE_OUT)
	start_button_hover_tween.tween_property($StartButton, "scale", Vector2(1.0, 1.0), 0.15)
	start_button_hover_tween.tween_property($StartButton, "rotation_degrees", 0.0, 0.15)


func _on_settings_button_mouse_entered() -> void:
	if is_settings_open or is_transitioning:
		return
	if settings_button_hover_tween:
		settings_button_hover_tween.kill()
	settings_button_hover_tween = create_tween()
	settings_button_hover_tween.set_parallel(true)
	settings_button_hover_tween.set_trans(Tween.TRANS_SINE)
	settings_button_hover_tween.set_ease(Tween.EASE_OUT)
	settings_button_hover_tween.tween_property($SettingsButton, "scale", Vector2(1.05, 1.05), 0.15)
	settings_button_hover_tween.tween_property($SettingsButton, "rotation_degrees", -2.0, 0.15)


func _on_settings_button_mouse_exited() -> void:
	if is_settings_open or is_transitioning:
		return
	if settings_button_hover_tween:
		settings_button_hover_tween.kill()
	settings_button_hover_tween = create_tween()
	settings_button_hover_tween.set_parallel(true)
	settings_button_hover_tween.set_trans(Tween.TRANS_SINE)
	settings_button_hover_tween.set_ease(Tween.EASE_OUT)
	settings_button_hover_tween.tween_property($SettingsButton, "scale", Vector2(1.0, 1.0), 0.15)
	settings_button_hover_tween.tween_property($SettingsButton, "rotation_degrees", 0.0, 0.15)

func _on_button_2_pressed() -> void:
	open_settings()

func _on_h_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))

func _on_start_button_pressed() -> void:
	EventBus.ON_START_GAME.emit()
	queue_free()


func _on_change_lenguage_button_pressed() -> void:
	if current_lenguage == "en":
		current_lenguage = lenguages[1]
		$LenguageSelector/CurrentLenguage.text = "Idioma"
		$LenguageSelector/MexicoFlag.visible = true
		$LenguageSelector/USAFlag.visible = false
	elif current_lenguage == "es":
		current_lenguage = lenguages[0]
		$LenguageSelector/CurrentLenguage.text = "Lenguage"
		$LenguageSelector/MexicoFlag.visible = false
		$LenguageSelector/USAFlag.visible = true
		


func _on_credits_button_pressed() -> void:
	pass


func _on_credits_button_mouse_entered() -> void:
	if is_settings_open or is_transitioning:
		return
	if credits_button_hover_tween:
		credits_button_hover_tween.kill()
	credits_button_hover_tween = create_tween()
	credits_button_hover_tween.set_parallel(true)
	credits_button_hover_tween.set_trans(Tween.TRANS_SINE)
	credits_button_hover_tween.set_ease(Tween.EASE_OUT)
	credits_button_hover_tween.tween_property($CreditsButton, "scale", Vector2(1.05, 1.05), 0.15)
	credits_button_hover_tween.tween_property($CreditsButton, "rotation_degrees", -1.5, 0.15)


func _on_credits_button_mouse_exited() -> void:
	if is_settings_open or is_transitioning:
		return
	if credits_button_hover_tween:
		credits_button_hover_tween.kill()
	credits_button_hover_tween = create_tween()
	credits_button_hover_tween.set_parallel(true)
	credits_button_hover_tween.set_trans(Tween.TRANS_SINE)
	credits_button_hover_tween.set_ease(Tween.EASE_OUT)
	credits_button_hover_tween.tween_property($CreditsButton, "scale", Vector2(1.0, 1.0), 0.15)
	credits_button_hover_tween.tween_property($CreditsButton, "rotation_degrees", 0.0, 0.15)
