extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _process(delta):
	#move_child(self.get_child(0),1);
	set_motion_offset(
		get_motion_offset()+Vector2(0,(30*delta))
	)
