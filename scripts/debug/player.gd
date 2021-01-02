extends KinematicBody2D


#func _ready():
#	print_debug(Input.get_joy_axis(0,0));

func _physics_process(delta):
	move_and_slide(Vector2(0,0)); # replace with speed
