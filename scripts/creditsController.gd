extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_menu"):
		var result = get_tree().change_scene(Globalvars.mainMenuScene);
		if result != 0:
			print_debug("Level load failed with errorcode: " + result);
