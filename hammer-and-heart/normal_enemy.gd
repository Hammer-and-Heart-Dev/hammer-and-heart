extends CharacterBody3D

var COOL_DOWN_SECONDS = 2;

@export var player : Player;
@export var speed : int = 10;
@export var acc : int = 1;
@export var fraction : int = 30;

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D


var health = 100;
var cooldown = false;


func _on_ready() -> void:
	nav_agent.path_desired_distance = 200;
	nav_agent.target_desired_distance = 50;
	nav_agent.path_max_distance = 200;

func _on_area_3d_area_entered(area: Area3D) -> void:
	if (area.is_in_group("weapon") and not cooldown):
		cooldown = true;
		health -= 10;
		print("ouch, current hp is ", health);

func _on_area_3d_area_exited(area: Area3D) -> void:
	await _delay(COOL_DOWN_SECONDS);
	cooldown = false;
	
func _delay(seconds:float) -> Signal:
	var timer = Timer.new();
	add_child(timer);
	timer.wait_time = seconds;
	timer.one_shot = true;
	timer.start();
	return timer.timeout;
	
func _physics_process(delta: float) -> void:
	var direction : Vector3 = (nav_agent.get_next_path_position() - global_position).normalized();
	_change_direction(direction.x);
	_set_movement_target();
	
	if not nav_agent.is_target_reached():
		if direction != Vector3.ZERO:
			velocity = velocity.move_toward(direction * speed, acc * delta);
	else:
		velocity = velocity.move_toward(Vector3.ZERO, fraction * delta);
		
	move_and_slide();
	
func _set_movement_target() -> void:
	await get_tree().physics_frame
	nav_agent.target_position = player.position - Vector3(0, 0, 0);
	
func _change_direction(direction:float) -> void:
	# print("do direction change")
	pass
		
	
	
