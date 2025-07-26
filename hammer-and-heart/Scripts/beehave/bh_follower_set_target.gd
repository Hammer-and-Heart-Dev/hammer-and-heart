class_name FollowerSetTarget extends ActionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	actor.set_target(actor.player.global_position)
	return SUCCESS
