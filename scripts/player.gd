extends KinematicBody2D

export var speed : int
export var shot_delay : int # Delay in Milliseconds

var shot
var shot_instance

var _delay_countdown

func _ready():
	shot = preload("res://prefabs/playershot.tscn")

func _physics_process(delta):
	# Function Binding
	if Input.is_action_pressed("mv_left"):
		move_and_slide(Vector2(speed*-1,0));
	if Input.is_action_pressed("mv_right"):
		move_and_slide(Vector2(speed,0));
	if Input.is_action_just_pressed("fire"):
		shot_instance = shot.instance()
		shot_instance.position = get_node("Pos_ShotSpawn").get_global_position();
		get_parent().add_child(shot_instance);
