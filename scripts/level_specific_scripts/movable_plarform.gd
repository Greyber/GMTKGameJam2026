extends StaticBody2D
class_name MovablePlatform

var is_player_on : bool
var speed : Vector2
var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	position += speed*delta
	if is_player_on:
		player.position += speed*delta
		

func _on_body_entered(body: Node2D) -> void:
	if not body == player: return 
	is_player_on = true

func _on_body_exited(body: Node2D) -> void:
	if not body == player: return 
	is_player_on = false
