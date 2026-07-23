extends StaticBody2D


var is_player_on : bool
var speed : Vector2
var player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	position += speed*delta
	if is_player_on:
		player.position += speed*delta
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body == player: return 
	is_player_on = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body == player: return 
	is_player_on = false
