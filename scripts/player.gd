extends KinematicBody2D

export(NodePath) onready var deathAnim = get_node(deathAnim)
var shot = preload("res://prefabs/Playershot.tscn")
var shot_instance

export var speed : int
export var shot_delay : float # Delay in Seconds
var invuln : bool = false

var _delay_countdown : float

func _ready():
	shot = preload("res://prefabs/Playershot.tscn")
	
func _physics_process(delta):
	# Calculating shot countdown
	_delay_countdown = _delay_countdown + delta;
	# Function Binding
	if Input.is_action_pressed("mv_left"):
		move_and_slide(Vector2(speed*-1,0));
	if Input.is_action_pressed("mv_right"):
		move_and_slide(Vector2(speed,0));
	if Input.is_action_pressed("fire"):
		if _delay_countdown >= shot_delay: fire_shot();

func fire_shot():
	shot_instance = shot.instance()
	shot_instance.position = get_node("Pos_ShotSpawn").get_global_position();
	get_parent().add_child(shot_instance);
	_delay_countdown = 0.0;

# when hitting another object, die.
func hit():
	if (invuln):
		return
	# notify playercontroller
	get_parent().playerDied();
	# play death animation
	remove_child(deathAnim)
	get_tree().get_root().add_child(deathAnim)
	deathAnim.set_global_position(self.get_global_position())
	deathAnim.playAnimation();
	queue_free()
