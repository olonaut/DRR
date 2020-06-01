extends Node2D

var mainMenuScene = "res://scenes/mainmenu.tscn";


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		var _loadResult = get_tree().change_scene(mainMenuScene);
		if _loadResult == OK:
			print_debug("Successfully switched level");
		else:
			print_debug("Switching levels failed. Errorcode : " + _loadResult);

