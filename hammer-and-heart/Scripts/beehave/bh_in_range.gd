class_name InRange
extends ConditionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	var _d = actor.player_in_range()
	if _d:
		actor.toggle_navigation(false)
		return SUCCESS
	else:
		return FAILURE
