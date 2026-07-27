extends Button

@export var has_hover_sound: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.pressed.connect(_on_pressed)
	
func _on_mouse_entered() -> void:
	if not has_hover_sound: return
	AudioManager.play_sfx(AudioManager.tracks.hover)

func _on_pressed() -> void:
	AudioManager.play_sfx(AudioManager.tracks.click)
	
