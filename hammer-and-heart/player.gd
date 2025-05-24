extends CharacterBody3D


const SPEED = 7.5
const JUMP_VELOCITY = 4.5

@onready var anim = $AnimationTree
var attacking = false


func _input(event):
	if attacking: return
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if event.is_action_pressed("Attack"):
		attacking = true
		anim["parameters/playback"].travel("Attack")
		#$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.set_process(true)
		
	elif direction:
		anim["parameters/playback"].travel("Walk")
	else:
		anim["parameters/playback"].travel("Idle")

func _physics_process(delta: float) -> void:
	#if not attacking:
		#$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.set_physics_process(false)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if attacking:
		direction = Vector3.ZERO
	
	if direction:
		#anim["parameters/playback"].travel("Walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if direction != Vector3.ZERO:
		direction = -direction.normalized()
		$Node.basis = Basis.looking_at(direction)
	move_and_slide()


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	#print(anim_name)
	if anim_name == "Greatswordslash":
		attacking = false
		#$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.set_process(false)
		
