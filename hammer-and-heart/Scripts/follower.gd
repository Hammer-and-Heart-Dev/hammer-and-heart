class_name Follower extends Agent
var COOL_DOWN_SECONDS = 2;

@export var player : Player;
@export var speed : int = 10;
@export var acc : int = 1;
@export var fraction : int = 30;
@export var distance_to_player : int = 5;
@export var run_distance : int = 15;

@onready var anim = $AnimationTree

func player_in_range():
	if position.distance_to(player.position) <= distance_to_player:
		return true
	else: 
		return false
		
func toggle_navigation(b : bool):
	super(b)
	if b == false:
		do_move_animation(0, 0)
	else:
		if(position.distance_to(player.position) >= run_distance):
			do_move_animation(0, 1)
		else:
			do_move_animation(0, 0.5)
	

func do_move_animation(x: float, y: float):
	anim.set("parameters/Movement/blend_position", Vector2(x, y))

func fire_projectile():
	anim.set("parameters/Kiss/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	#TODO: spawn and launch heart projectile
