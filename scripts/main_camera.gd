extends Camera2D

var player 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _process(delta: float) -> void:
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")

	if is_instance_valid(player):
		position += ((player.position - position) / 0.5) * delta
