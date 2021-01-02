extends ParallaxLayer

func _process(delta):
	#move_child(self.get_child(0),1);
	set_motion_offset(
		get_motion_offset()+Vector2(0,0.5)
	)
	pass

func _ready():
	#setmotionoffset(Vector2(50,50))
	pass
