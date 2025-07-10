class_name FaceTarget extends ActionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	actor.rotate_self = true
	actor.rotate_target = actor.enemy.global_position
	actor.rotate_node = actor.enemy
	return RUNNING
