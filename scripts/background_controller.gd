extends TextureRect

func _process(delta):
	var oldPos : Vector2 = self.get_global_position();
	self.set_global_position(oldPos + Vector2(0,1));
