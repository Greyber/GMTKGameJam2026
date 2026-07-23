extends Node

func execute_action(action_type: Global.ACTIONS_TYPE, objectives: Array, args: Array) -> void:
	match action_type:
		Global.ACTIONS_TYPE.OPEN_DOOR:
			objectives[0].toggle(args[0])
