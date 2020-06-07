extends Node2D

var mainMenuScene = "res://scenes/mainmenu.tscn";

# references to the level container
var levelcontainer;

# references to the levels
var levels;

# What stage the player has currently selected
var playperPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children();

	# Find level container
	for n in children:
		if n.name == "levelContainer":
			print_debug("Found level Container! " + n.to_string());
			levelcontainer = n;
			break;
	
	# Apply reference to the levels
	levels = levelcontainer.get_children();
	
	# Found n levels
	print_debug("Found " + str(len(levels)) + " levels.")


func _process(_delta):
	# Back to main Menu
	if Input.is_action_pressed("ui_cancel"):
		var _loadResult = get_tree().change_scene(mainMenuScene);
		if _loadResult == OK:
			print_debug("Successfully switched level");
		else:
			print_debug("Switching levels failed. Errorcode : " + _loadResult);
	

func movePlayerToLevel(var level):

	pass
