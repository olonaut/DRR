extends Node2D

func playAnimation():
	for _i in self.get_children():
		_i.set_emitting(true);
