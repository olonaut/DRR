extends Label

export(Resource) var newscene;
export(bool) var exitsGame;

func _ready():
	pass 


func _process(delta):
	pass

func _gui_input(InputEvent):
	print("lol");
	pass

#func _input(event):
#	print(event);
#	if event is InputEventMouseButton and event.is_pressed():
#		if exitsGame: get_tree().quit();
#		print_debug("Buttonpress detected at viewport pos", get_viewport().get_mouse_position());
#		print_debug("Changing Scene to " + newscene.get_path());
#		var _changescene = get_tree().change_scene(newscene.get_path());
#		if _changescene == 0:
#			print_debug("Success");
#		else:
#			print_debug("Failed to Change Scenes. Code " + _changescene);
#		
#	pass
