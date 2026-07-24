extends Camera2D

var player 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	position += ((player.position - position) / 0.5) * delta

func set_loading_next_level_state():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "limit_bottom", 1312, 5)
	tween.parallel().tween_property(self, "zoom", Vector2(3, 3), 2)

func set_normal_state():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "zoom", Vector2(2, 2), 2)
