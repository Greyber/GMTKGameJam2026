extends Node2D

@export var current_text : int = 0
var all_texts : Dictionary = {
	1:[
	  "Hello!", 
	  "Do you see that timer counting down up there?", 
	  "When it reaches zero, the level will restart", 
	  "Every time this happens, a shadow will be created that replicates your movements from the previous cycle", 
	  "You can also force a restart with R", 
	  "Also, if you stand still, time won't pass", 
	  "However, if you press Q you will restart the level and erase all existing shadows",
	  "Also keep in mind that you can collide with your shadows", 
	  "GOOD LUCK"
	],
	2:["What will happen if you restart the cycle while being in the air?"],
	3:[
	  "What is that?", 
	  "I guess that was supposed to be the end", 
	  "But there is no way to get there", 
	  "There isn't enough time and there is no other method", 
	  "Maybe if I had a little more time we would know what it is", 
	  "Anyways", 
	  "If you made it this far, I can only tell you one thing", 
	  "Thank you very much for playing"
	]
}
var is_player_in : bool
var text_index = 0

func _ready() -> void:
	$Label.text = all_texts[current_text][0]
	$InteractuableArea._on_interact.connect(_interact)
	
func _interact(_by_whom) -> void:
	if not is_player_in: return
	text_index += 1
	if text_index < len(all_texts[current_text]):
		$Label.text = all_texts[current_text][text_index]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		$Label.visible = true
		is_player_in = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		$Label.visible = false
		is_player_in = false
		text_index = 0
		$Label.text = all_texts[current_text][0]
