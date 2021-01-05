extends KinematicBody2D

export var speed : int


func _physics_process(delta):
	if Input.is_action_pressed("mv_left"):
		move_and_slide(Vector2(speed*-1,0)); # multiply with speed
		#print_debug("left");
	if Input.is_action_pressed("mv_right"):
		move_and_slide(Vector2(speed,0)); # multiply with speed
		#print_debug("right")
	#move_and_slide(Vector2(0,1));
