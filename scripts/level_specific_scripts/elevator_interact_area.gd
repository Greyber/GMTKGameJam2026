extends Area2D

signal on_interact

func interact(_by_whom: Node2D) -> void:
	on_interact.emit()
