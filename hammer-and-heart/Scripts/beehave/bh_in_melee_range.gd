class_name InMeleeRange extends ConditionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	if actor.enemy == null:
		return FAILURE

	if actor.global_position.distance_to(actor.enemy.global_position) <= actor.melee_range:
		return SUCCESS
	else:
		return FAILURE
