extends CharacterBody3D
class_name Player

const SPEED = 5
const RUN_SPEED = 10.0
const JUMP_VELOCITY = 10.0
const ROTATION_SPEED: float = 15.0

@onready var anim = $AnimationTree
var attacking: bool = false
var sprinting: bool


func _input(event):
	if attacking: return
	if event.is_action_pressed("Attack"):
		attacking = true
		$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.process_mode = Node.PROCESS_MODE_ALWAYS
		anim.set("parameters/Attack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _ready() -> void:
	sprinting = false
	$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.process_mode = Node.PROCESS_MODE_DISABLED
	
func _physics_process(delta: float) -> void:
	var target_velocity = Vector3()
	# Add the gravity.
	if not is_on_floor():
		target_velocity += get_gravity() * delta * 9.8


	# Handle sprint
	if Input.is_action_pressed("Sprint"):
		sprinting = false
	else:
		sprinting = true
	#var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var input_dir := Vector3(Input.get_axis("Left", "Right"), 0, Input.get_axis("Forward", "Back")).normalized()

	
	if input_dir and not attacking:
		#determine movement animation to use
		if sprinting:
			anim.set("parameters/Movement/blend_position", Vector2(0, 0.5))
			target_velocity.x = input_dir.x * SPEED
			target_velocity.z = input_dir.z * SPEED
		else :
			anim.set("parameters/Movement/blend_position", Vector2(0, 1.0))
			target_velocity.x = input_dir.x * SPEED * 2
			target_velocity.z = input_dir.z * SPEED * 2
	else:
		anim.set("parameters/Movement/blend_position", Vector2(0, 0))
		sprinting = false
		target_velocity.x = 0
		target_velocity.z = 0
		
	velocity = target_velocity
	move_and_slide()
		
	if !attacking and (Vector3(velocity.x, 0, velocity.z).length() > 0.1 or input_dir.length() > 0.1):
		_rotate_towards($Node.position - input_dir, delta, ROTATION_SPEED)
	

func _rotate_towards(target: Vector3, delta: float, speed: float) -> void:
	var target_dir = ($Node.position - target).normalized()
	var target_rotation = atan2(target_dir.x, target_dir.z)
	$Node.rotation.y = lerp_angle($Node.rotation.y, target_rotation, min(delta * speed, 1))
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	#print(anim_name)
	if anim_name == "Greatswordslash":
		attacking = false
		$Node/Skeleton3D/WeaponAttachment/Hammer/Hitbox.process_mode = Node.PROCESS_MODE_DISABLED
		
