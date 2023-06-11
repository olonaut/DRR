extends Button

@export var newscene: Resource;
@export var exitsGame: bool;
@export var hasFocus: bool;

func _ready():
	var _bindButton = self.connect("pressed", Callable(self, "loadScene"));
	if _bindButton == 0:
		print_debug("Button binding successful");
	else:
		print_debug("Button binding failed with code " + _bindButton);
	if hasFocus:
		self.grab_focus();
	pass
	
func loadScene():
	if exitsGame:
		print_debug("Exiting Game...");
		get_tree().quit();
	else:
		print_debug("Changing Scene to " + newscene.get_path());
		var _changescene = get_tree().change_scene_to_file(newscene.get_path());
		if _changescene == 0:
			print_debug("Success");
		else:
			print_debug("Failed to Change Scenes. Code " + _changescene);
	pass
