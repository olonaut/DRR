extends ParallaxLayer

func _process(delta):
	#move_child(self.get_child(0),1);
	set_motion_offset(
		get_motion_offset()+Vector2(0,(30*delta))
	)
