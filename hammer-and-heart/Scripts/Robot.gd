extends RigidBody3D
var health = 100
var cooldown = false

func _on_attack_detector_area_entered(area: Area3D) -> void:
	if(area.is_in_group("weapon") and not cooldown):
		cooldown = true
		print("ouch!")
		health -= 10
		print("health: " + str(health))
		if(health <= 0):
			queue_free()


func _on_attack_detector_area_exited(area: Area3D) -> void:
	cooldown = false
