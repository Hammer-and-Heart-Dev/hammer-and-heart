
extends Area3D
class_name NPCSenses

@export var self_collider : Area3D

@export var current_agents : Array[Area3D] = []

@export var current_enemies : Array[Area3D] = []


func _process(_delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("player"):
		print("Enemy sees player")
		current_enemies.append(area)


func _on_area_exited(area):
	current_agents.erase(area)
	current_enemies.erase(area)


func has_enemies() -> bool:
	if current_enemies.size() > 0:
		return true
	else:
		return false

func get_enemy() -> Node3D:
	if current_enemies.size() > 0:
		return current_enemies[0] as Node3D
	else:
		return null
