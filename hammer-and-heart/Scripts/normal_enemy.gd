class_name SpiderBotAgent
extends Agent

var COOL_DOWN_SECONDS = 2;

@export var player : Player;
@export var speed : int = 10;
@export var acc : int = 1;
@export var fraction : int = 30;
var enemy : Node3D

#@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@export_category("Enemy Agent Settings")

@export var melee_range : float = 2
@export var health = 100;
const ROTATION_SPEED: float = 15.0

func _ready() -> void:
	$Attack.process_mode = Node.PROCESS_MODE_DISABLED
	

func _delay(seconds:float) -> Signal:
	var timer = Timer.new();
	add_child(timer);
	timer.wait_time = seconds;
	timer.one_shot = true;
	timer.start();
	return timer.timeout;


func _on_hitbox_area_entered(area: Area3D) -> void:
	if area.is_in_group("weapon"):
		health -= 10
		print("ouch, current hp is: " + str(health))
		if health <= 0:
			is_alive = false
