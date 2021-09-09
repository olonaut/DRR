extends Node2D

func playAnimation():
	for _i in self.get_children():
		if _i is Particles2D: _i.set_emitting(true);
		elif _i is AudioStreamPlayer2D: _i._set_playing(true)
